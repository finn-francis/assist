# frozen_string_literal: true

require 'optparse'

module Assist
  module UI
    class MenuCommand
      attr_accessor :option_parser

      class Command
        def options
          @options ||= []
        end

        def banner(new_banner = nil)
          @banner ||= new_banner
        end

        def option(keyword, small_name, big_name, description)
          options << {
            small_name: small_name,
            big_name: big_name,
            description: description,
            keyword: keyword
          }
        end
      end

      def call(arguments)
        case handler
        when :render then :render
        when :exit then :exit
        else
          argument_list = arguments.split
          option_parser&.parse!(argument_list)
          handler.call(args, argument_list)
        end
      end

      def args
        @args ||= {}
      end

      def render
        puts [
          self.name,
          'Aliases: ' + [*self.aliases].join(', '),
          "Usage: #{self.description}",
          "\n"
        ].join("\n")
      end

      def options(&block)
        command = Command.new
        command.instance_eval(&block)

        self.option_parser = OptionParser.new do |parser|
          parser.banner = command.banner

          command.options.each do |option|
            parser.on(option[:small_name], option[:big_name], option[:description]) do |result|
              args[option[:keyword]] = result
            end
          end

          parser.on('-h', '--help', 'Display options') do
            puts parser
            args[:help] = true
          end
        end
      end

      def name(new_name = nil)
        @name ||= new_name
      end

      def description(new_desc = nil)
        @description ||= new_desc
      end

      def aliases(new_aliases = [])
        @aliases ||= new_aliases
      end

      def handler(class_name = nil)
        @handler ||= class_name
      end

      class << self
        def build(&block)
          menu_command = self.new
          menu_command.instance_eval(&block)
          menu_command
        end
      end
    end
  end
end
