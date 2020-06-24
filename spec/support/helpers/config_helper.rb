# frozen_string_literal: true

require 'pathname'
require 'json'

# This helper allows us to run this test suite in multiple environments.
#
# As the application requires specific directory structures this module
# generates all of the required absolute paths and gives us an interface
# that we can use to test the functionality properly.
module ConfigHelper
  class << self
    def project_root
      @project_root ||= Pathname(Dir.getwd)
    end

    def fake_directory
      return @fake_directory if @fake_directory

      # This is necessary due to some strange behavior when running rspec with different commands
      # When running `rspec` on it's own project_root ends with '/spec'
      # However when running `rspec <FILENAME>` it ends with the above directory
      directories = %w[support fake_directory .assist]
      directories.unshift('spec') unless project_root.basename.to_s == 'spec'
      @fake_directory = project_root.join(*directories)
    end

    def workspace_config_path
      @workspace_config_path ||= fake_directory.join('config', 'workspace_config.json')
    end

    # Run this whenever testing the workspace config
    def generate_workspace_config_path
      File.open(workspace_config_path, File::CREAT | File::WRONLY) do |file|
        file.write(JSON.pretty_generate({ workspace_path: fake_directory}))
      end
    end
  end
end
