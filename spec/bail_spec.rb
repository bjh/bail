require 'spec_helper'
require 'bail.rb'

Bail.suppress_output = true

describe Bail do
  describe '.when' do
    context 'passing a block as the condition' do
      it 'raises an error when any item is true' do
        expect {
          Bail.when(nil, 3, 3) do |x|
            x.nil?
          end
        }.to raise_error
      end
    end
  end

  describe '.when_any' do
    context 'using a lambda as the condition' do
      it 'raises an error when any item is true' do
        expect {
          Bail.when_any(->(x){x.nil?}, 1, nil, 3)
        }.to raise_error
      end
    end

    context 'using a symbol as the condition' do
      it 'raises an error when any item is true' do
        expect {
          Bail.when_any(:nil?, 1, 2, nil)
        }.to raise_error
      end

      it 'does not raise an error when all items are false' do
        expect {
          Bail.when_any(:nil?, 1, 2, 3)
        }.not_to raise_error
      end
    end

    context 'using a Hash as the condition' do
      it 'raises an error when any item is true' do
        expect {
          Bail.when_any({is_a: String}, 1, 2, '3')
        }.to raise_error
      end

      it 'does not raise an error when all items are false' do
        expect {
          Bail.when_any({is_a: String}, 1, 2, 3)
        }.not_to raise_error
      end
    end
  end

  describe '.when_all' do
    it 'raises an error when all items are true' do
      expect {
        Bail.when_all(:nil?, nil, nil, nil)
      }.to raise_error
    end

    it 'does not raise an error if any item is false' do
      expect {
        Bail.when_all(:nil?, nil, nil, 3)
      }.not_to raise_error
    end
  end

  # describe '.when_one' do
  #   it 'returns true of exactly one item is true' do
  #     expect {
  #       Bail.when_one(:nil?, 1, 2, nil)
  #     }.to raise_error
  #   end
  #
  #   it 'does not raise an error if all items are false' do
  #     expect {
  #       Bail.when_one(:nil?, nil, nil, nil)
  #     }.not_to raise_error
  #   end
  # end
  #
  # describe '.when_not_all' do
  #   it 'raises an error if anything is true' do
  #     expect {
  #       Bail.when_not_all(:nil?, nil, 2, nil)
  #     }.to raise_error
  #   end
  #
  #   it 'does not raise an error if all items are false' do
  #     expect {
  #       Bail.when_not_all(:nil?, nil, nil, nil)
  #     }.not_to raise_error
  #   end
  # end
end
