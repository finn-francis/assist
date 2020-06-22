# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../lib/commands/cd'

RSpec.describe Assist::Commands::CD do
  describe '#call' do
    context 'with argument: -h' do
      it 'should return :ok' do
        expect(described_class.call({ help: true }, ['cd'])).to eq(:ok)
      end
    end

    context 'with a directory as an argument' do
      it 'should call the #chdir method' do
        dir_module = double('dir_module')
        stub_const('Dir', dir_module)

        expect(dir_module).to receive(:chdir).with('/my/route')

        described_class.call({}, %w[cd /my/route])
      end

      context 'the directory does not exist' do
        it 'should return :error' do
          expect(described_class.call({}, %w[cd non/existant/route])).to eq(:error)
        end
      end

      context 'the directory does exist' do
        it 'should return :ok' do
          expect(described_class.call({}, %w[cd spec])).to eq(:ok)
        end
      end
    end
  end
end
