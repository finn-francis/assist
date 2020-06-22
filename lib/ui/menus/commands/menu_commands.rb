# frozen_string_literal: true

require_relative './menu_command'

module Assist
  module UI
    module MenuCommands
      def self.included(base)
        base.extend(ClassMethods)
      end

      def command_objects
        self.class.command_objects
      end

      def commands
        self.class.commands
      end

      module ClassMethods
        def menu_commands
          yield
        end

        def command_objects
          @command_objects ||= []
        end

        def commands
          @commands ||= {}
        end

        def command(&block)
          new_command = MenuCommand.build(&block)
          command_objects << new_command
          [new_command.name, *new_command.aliases].each do |command_name|
            commands[command_name] = new_command
          end
        end
      end
    end
  end
end
