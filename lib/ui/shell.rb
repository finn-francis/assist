# frozen_string_literal: true

require 'readline'
require_relative './menus/main_menu'

module Assist
  module UI
    class Shell
      def initialize(prompt:)
        @prompt = prompt
      end

      def menu
        @menu ||= Assist::UI::MainMenu.new
      end

      def start
        exit_in = Float::INFINITY
        loop do
          break if exit_in < 1

          input = ::Readline.readline(@prompt.to_s, '')

          case menu.handle_input(input)
          when :exit
            exit_in = 0
          when :render
            menu.render
          when :ok
            true
          else
            puts "#{input}: command not found\nRun `help` for options" if system(input).nil? && !input.empty?
          end

          exit_in = Float::INFINITY unless exit_in.zero?

        # Interrupt is called when we press ctrl+c, rescuing it will allow
        # us to keep usual commandline ctrl+c functionality
        rescue Interrupt
          exit_in = exit_in == 1 ? 0 : 1
          print "\n"
        end

        puts 'Exiting...'
      end
    end
  end
end
