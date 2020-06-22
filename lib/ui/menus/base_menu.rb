# frozen_string_literal: true

require_relative './commands/menu_commands'

module Assist
  module UI
    class BaseMenu
      include MenuCommands

      def handle_input(input)
        command = input[/[^\s]+/]
        commands[command]&.call(input)
      end

      def render
        puts "\n"
        command_objects.each(&:render)
        puts "\n"
      end
    end
  end
end
