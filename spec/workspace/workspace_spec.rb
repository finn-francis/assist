# frozen_string_literal: true

require 'pathname'

require_relative '../spec_helper'
require_relative '../support/helpers/config_helper'

require_relative '../../main'
require_relative '../../lib/workspace/workspace'

describe Assist::Workspace do
  let(:dir) { Pathname.new '/fake/directory' }

  it 'should have the WORKSPACE_CONFIG_FILE constant' do
    expect(described_class::WORKSPACE_CONFIG_FILE).to eq('workspace_config.json')
  end

  describe '#initialize' do
    let(:workspace) { described_class.new }

    before { allow(Dir).to receive(:getwd).and_return(dir.to_s) }

    it 'should set path variables to the workspace and config' do
      expect(workspace.workspace_path).to eq(dir)
      expect(workspace.assist_path).to eq(dir.join('.assist'))
      expect(workspace.config_path).to eq(dir.join('.assist', 'config'))
      expect(workspace.workspace_config_path).to eq(dir.join('.assist', 'config', 'workspace_config.json'))
    end
  end

  describe '#init' do
    it 'should give Assist a workspace' do
      expect(Assist.workspace).to be_nil
      described_class.init
      expect(Assist.workspace).to_not be_nil
    end

    describe 'config' do
      before do
        allow(Dir).to receive(:getwd).and_return(ConfigHelper.fake_directory.parent)
        described_class.init
      end

      it 'should add a workspace and config to the Assist module' do
        expect(Assist.workspace.assist_path).to eq(ConfigHelper.fake_directory)
        expect(Assist.workspace.config).to be_a(Assist::Workspace::Config)
        expect(Assist.workspace.config_path).to eq(ConfigHelper.fake_directory.join('config'))
        expect(Assist.workspace.workspace_path).to eq(ConfigHelper.fake_directory.parent)
      end

      it 'should add the :workspace key to the Assist config' do
        expect(Assist.config[:workspace]).to_not be_nil
      end
    end
  end
end
