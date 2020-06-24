# frozen_string_literal: true

require 'pathname'
require 'fileutils'

require_relative './config'

module Assist
  class Workspace
    WORKSPACE_CONFIG_FILE = 'workspace_config.json'

    attr_accessor :workspace_path, :assist_path, :config_path, :workspace_config_path, :config

    def initialize
      self.workspace_path        = Pathname.new(Dir.getwd)
      self.assist_path           = self.workspace_path.join('.assist')
      self.config_path           = self.assist_path.join('config')
      self.workspace_config_path = self.config_path.join(WORKSPACE_CONFIG_FILE)
    end

    def init_config
      find_or_create_dir
      find_or_create_config
      load_config
    end

    class << self
      def init
        Assist.workspace = Workspace.new.tap(&:init_config)
      end
    end

    private

    def find_or_create_dir
      FileUtils.mkdir_p(self.config_path)
    end

    def find_or_create_config
      return if File.exist?(self.workspace_config_path)

      temp_filename = (1..10).inject('') do |string, _num|
        string + [*('a'..'z').to_a, *('0'..'9').to_a].sample
      end
      File.open(temp_filename, File::WRONLY | File::CREAT) { |file| file.write('{}') }
      File.rename(temp_filename, self.workspace_config_path)
    end

    def load_config
      self.config = Config.new(self.workspace_config_path)
      Assist.config[:workspace] = self.config
    end
  end
end
