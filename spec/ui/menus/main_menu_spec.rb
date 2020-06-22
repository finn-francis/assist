# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/ui/menus/main_menu'

RSpec.describe Assist::UI::MainMenu do
  it 'should inherit from base_menu' do
    expect(described_class.superclass).to eq(Assist::UI::BaseMenu)
  end

  describe 'command_objects' do
    it 'should have the relevent command_objects' do
      expect(described_class.command_objects.count).to eq(3)
    end

    it 'should set aliases for each command' do
      %w[help h ? exit quit cd].each do |command|
        expect(described_class.commands[command]).to_not be_nil
      end
    end
  end
end
