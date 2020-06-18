# frozen_string_literal: true

require 'optparse'

module Assist
  module UI
    class MenuCommand
      attr_accessor :name, :description, :aliases, :option_parser

      class Command
        attr_accessor :banner

        def options
          @options ||= []
        end

        def on(small_name, big_name, description, keyword:)
          options << {
            small_name: small_name,
            big_name: big_name,
            description: description,
            keyword: keyword
          }
        end
      end

      def args
        @args ||= {}
      end

      def options
        command = Command.new
        yield(command)

        self.option_parser = OptionParser.new do |parser|
          parser.banner = command.banner

          command.options.each do |option|
            parser.on(option[:small_name], option[:big_name], option[:description]) do |result|
              args[option[:keyword]] = result
            end
          end
        end
      end

      class << self
        def build
          menu_command = self.new

          yield(menu_command)

          menu_command
        end
      end
    end

    class MenuCommands
    end
  end
end
