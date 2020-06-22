# frozen_string_literal: true

require_relative './base_menu.rb'
require_relative '../../commands/cd.rb'

module Assist
  module UI
    class MainMenu < BaseMenu
      menu_commands do
        command do
          name 'help'
          aliases %w[h ?]
          description 'Displays the help menu'
          handler :render

          options do
            banner 'Usage: help [options]'
          end
        end

        command do
          name 'exit'
          aliases %w[quit]
          description 'Quits the program'
          handler :exit
        end

        command do
          name 'cd'
          description "Change the working directory\nUsage: cd [DIRECTORY] [OPTIONS]"
          handler Assist::Commands::CD

          options do
            banner 'Change the shell working directory'
            option :links, '-L', '--links', "Force symbolic links to be followed: resolve symbolic links in DIR after processing instances of `..'"
            option :physical, '-P', '--physical', "Symbolic links: resolve symbolic links in DIR before processing instances of `..'"
            option :escape, '-e', '--escape', 'If the -P option is supplied, and the current working directory cannot be determined successfully, exit with a non-zero status'
            option :file, '-@', '--file', 'On systems that support it, present a file with extended attributes as a directory containing the file attributes'
          end
        end
      end
    end
  end
end
