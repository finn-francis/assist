# frozen_string_literal: true

require 'readline'

module Assist
  class Shell
    def initialize(prompt:)
      @prompt = prompt
    end

    def start
      exit_in = Float::INFINITY
      loop do
        begin
          break if exit_in < 1

          input = ::Readline.readline(@prompt.to_s, '')

          case command = input[/\w+/]
          when 'exit'
            exit_in = 0
          when 'cd'
            Dir.chdir(input.sub(command, '').strip)
            puts Dir.getwd
          else
            puts "#{input}: command not found" if system(input).nil? && !input.empty?
          end

          exit_in = Float::INFINITY unless exit_in.zero?

        # Interrupt is called when we press ctrl+c, rescuing it will allow
        # us to keep usual commandline ctrl+c functionality
        rescue Interrupt
          exit_in = exit_in == 1 ? 0 : 1
          print "\n"
        end
      end

      puts 'Exiting...'
    end
  end
end
