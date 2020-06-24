# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../support/helpers/config_helper'
require_relative '../../lib/workspace/config'

RSpec.describe Assist::Workspace::Config do
  let(:config) { described_class.new(ConfigHelper.workspace_config_path) }
  before { ConfigHelper.generate_workspace_config_path }

  describe '#config_path' do
    it 'should be set to the path containing the workspace_config.json file' do
      expect(config.workspace_path).to eq(ConfigHelper.fake_directory)
      expect(File.exist?(config.workspace_path)).to be(true)
    end
  end

  describe '#load_config' do
    it 'should set all of the config variables' do
      expect(config.workspace_path).to eq(ConfigHelper.fake_directory)
      expect(config.config_path).to eq(ConfigHelper.workspace_config_path)
    end
  end
end
