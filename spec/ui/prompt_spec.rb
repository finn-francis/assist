# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/ui/prompt'

RSpec.describe Assist::UI::Prompt do
  describe '#to_s' do
    let(:username) { 'user' }
    let(:prompt) { described_class.new }
    before { ENV['USERNAME'] = username }

    it 'should return a prompt based on the username' do
      expect(prompt.to_s).to eq("#{username}@assist:#{File.basename(Dir.getwd)}> ")
    end
  end
end
