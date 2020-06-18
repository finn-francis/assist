# frozen_string_literal: true

module Assist
  module UI
    class Prompt
      def initialize
        @username = ENV['USERNAME']
      end

      def to_s
        [
          @username,
          '@assist:',
          File.basename(Dir.getwd),
          '> '
        ].join
      end
    end
  end
end
