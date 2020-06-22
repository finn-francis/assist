# frozen_string_literal: true

require_relative '../../spec_helper'
require_relative '../../../lib/ui/menus/base_menu'

RSpec.describe Assist::UI::BaseMenu do
  let(:menu) { described_class.new }

  describe '#handle_input' do
    it 'should call the #call command for the given command handler' do
      handler = double('handler')
      expect(handler).to receive(:call).with('help')

      menu.commands['help'] = handler
      menu.handle_input('help')
    end
  end

  describe '#render' do
    # Supresses the console output for the test
    around do |examples|
      @original_stdout = $stdout
      $stdout = File.open(File::NULL, 'w')

      examples.run

      $stdout = @original_stdout
    end

    it 'should call the render method on each of the command_objects' do
      command_object = double('command_object')
      expect(command_object).to receive(:render)

      menu.command_objects << command_object
      menu.render
    end
  end
end
