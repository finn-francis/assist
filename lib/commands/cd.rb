# frozen_string_literal: true

module Assist
  module Commands
    module CD
      class << self
        # TODO: implement the args to immitate bash cd functionality
        def call(args, argument_list)
          return :ok if args[:help]

          Dir.chdir(argument_list[1])
          :ok
        # Errno::ENOENT rescues in case the directory does not exist
        # TypeError catches any request made without an argument
        rescue Errno::ENOENT, TypeError
          # TODO: print out a message to inform the user the file does not exist
          :error
        end
      end
    end
  end
end
