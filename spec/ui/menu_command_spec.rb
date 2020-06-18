# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/ui/menus/menu_command.rb'

RSpec.describe Assist::UI::MenuCommand do
  let(:help_command) do
    described_class.build do
      name        'help'
      aliases     %w[h ?]
      description 'Displays app usage'

      options do
        banner 'Usage: help [options]'
        option :verbose, '-v', '--[no]-verbose', 'Run verbosely'
      end
    end
  end

  describe '#build' do
    it 'should build out a new command' do
      expect { help_command }.to_not raise_error

      expect(help_command).to be_a(described_class)
    end
  end

  xdescribe 'attributes' do
    it 'should have getters for name, aliases and description' do
      expect(help_command.name).to eq('help')
      expect(help_command.description).to eq('Displays app usage')
      expect(help_command.aliases).to eq(%w[h ?])
    end

    it 'should have setters for name, aliases and description' do
      help_command.name        = 'new_name'
      help_command.description = 'new description'
      help_command.aliases     = %w[one two]

      expect(help_command.name).to eq('new_name')
      expect(help_command.description).to eq('new description')
      expect(help_command.aliases).to eq(%w[one two])
    end
  end

  describe Assist::UI::MenuCommand::Command do
    describe '#option' do
      let(:values) do
        {
          small_name: 'small',
          big_name: 'big',
          description: 'description',
          keyword: :keyword
        }
      end

      it 'should add a new hash to the options array with options for the parser' do
        command = described_class.new
        expect(command.options).to eq([])

        command.option(values[:keyword], values[:small_name], values[:big_name], values[:description])
        expect(command.options.first[:small_name]).to eq(values[:small_name])
        expect(command.options.first[:big_name]).to eq(values[:big_name])
        expect(command.options.first[:description]).to eq(values[:description])
        expect(command.options.first[:keyword]).to eq(values[:keyword])
      end
    end
  end
end
