# frozen_string_literal: true

require_relative './lib/ui/shell'
require_relative './lib/ui/prompt'

module Assist
  class << self
    def init
      prompt = UI::Prompt.new
      shell  = UI::Shell.new(prompt: prompt)
      shell.start
    end
  end
end

Assist.init
