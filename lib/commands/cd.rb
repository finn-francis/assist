# frozen_string_literal: true

module Assist
  module Commands
    module CD
      class << self
        # TODO: implement the args to immitate bash cd functionality
        def call(_args, argument_list)
          return :ok if (argument_list & %w[-h --help]).any?

          Dir.chdir(argument_list[1])
          :ok
        rescue Errno::ENOENT
          # TODO: print out a message to inform the user the file does not exist
          :error
        end
      end
    end
  end
end
