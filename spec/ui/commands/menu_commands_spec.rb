# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/ui/menus/commands/menu_commands'

RSpec.describe Assist::UI::MenuCommands do
  let(:menu_with_commands) do
    Class.new do
      include Assist::UI::MenuCommands

      menu_commands do
        command do
          name 'help'
          aliases %w[h ?]
          description 'description'
          handler :render
        end
      end
    end
  end
  let(:expected_results) do
    {
      name: 'help',
      aliases: %w[h ?],
      description: 'description',
      handler: :render
    }
  end

  describe '#menu_commands' do
    it 'should allow the including class to build commands using the menu_commands method' do
      expect { menu_with_commands }.to_not raise_error

      expected_results.each do |k, v|
        expect(menu_with_commands.command_objects.first.send(k)).to eq(v)
      end
    end
  end

  describe '#command_objects' do
    it 'should contain all of the command info' do
      object = menu_with_commands.command_objects.first
      expect(object).to be_a(Assist::UI::MenuCommand)

      expected_results.each do |k, v|
        expect(object.send(k)).to eq(v)
      end
    end
  end

  describe '#commands' do
    it 'should have a hash containing a command for each of the command aliases' do
      %w[help h ?].each do |command|
        expected_results.each do |k, v|
          expect(menu_with_commands.commands[command].send(k)).to eq(v)
        end
      end
    end
  end

  describe '#command' do
    let(:menu_class) { Class.new.include(described_class) }

    it 'should allow users to add a new command' do
      menu_class.command do
        name 'new'
        aliases %w[n]
        description 'new command'
        handler :exit
      end

      expect(menu_class.command_objects.first.name).to eq('new')
      expect(menu_class.command_objects.first.aliases).to eq(%w[n])
      expect(menu_class.command_objects.first.description).to eq('new command')
      expect(menu_class.command_objects.first.handler).to eq(:exit)
    end
  end
end
