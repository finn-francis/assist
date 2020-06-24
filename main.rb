# frozen_string_literal: true

require_relative './lib/ui/shell'
require_relative './lib/ui/prompt'
require_relative './lib/workspace/workspace'

module Assist
  class << self
    attr_accessor :workspace

    def init
      init_workspace
      prompt = UI::Prompt.new
      shell  = UI::Shell.new(prompt: prompt)
      shell.start
    end

    def config
      @config ||= {}
    end

    # Sets the workspace variable and config[:workspace]
    def init_workspace
      Workspace.init
    end
  end
end

Assist.init unless ENV['TEST'] == '1'
