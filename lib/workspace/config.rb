# frozen_string_literal: true

require 'json'

module Assist
  class Workspace
    class Config
      SETTINGS = %i[config_path workspace_path].freeze

      attr_accessor(*SETTINGS)

      def initialize(config_path)
        self.config_path = config_path
        load_config
      end

      private

      def load_config
        settings = JSON.parse(File.read(self.config_path))
        settings.each do |k, v|
          value = k.to_s.match?(/_path$/) ? Pathname.new(v) : v

          self.send("#{k}=", value)
        end
      end
    end
  end
end
