# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/ui/menus/commands/menu_command'

RSpec.describe Assist::UI::MenuCommand do
  let(:help_command) do
    described_class.build do
      name        'help'
      aliases     %w[h ?]
      description 'Displays app usage'
      handler     Class.new

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

  describe 'attributes' do
    it 'should have getters for name, aliases and description' do
      expect(help_command.name).to eq('help')
      expect(help_command.description).to eq('Displays app usage')
      expect(help_command.aliases).to eq(%w[h ?])
    end
  end

  describe '#call' do
    context ':exit' do
      it 'should return the :exit symbol' do
        command = described_class.build do
          handler :exit
        end

        expect(command.call('')).to eq(:exit)
      end
    end

    context ':render' do
      it 'should return the :render symbol' do
        command = described_class.build do
          handler :render
        end

        expect(command.call('')).to eq(:render)
      end
    end

    context 'class' do
      it 'should call the #call method on the call handler' do
        command = described_class.build do
          class ClassHandlerTest
            def call(_, _args = [])
              'called'
            end
          end
          handler ClassHandlerTest.new
        end

        expect(command.call('')).to eq('called')
      end
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
