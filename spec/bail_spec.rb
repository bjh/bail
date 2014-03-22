require 'spec_helper'
require 'bail.rb'

describe Bail do
  before :each do
    Bail.suppress_output = true
    Bail.raise_on_error = false
  end

  after :each do
    Bail.suppress_output = false
    Bail.raise_on_error = true
  end

  describe '.behavior' do
    context 'raise_on_error' do
      it 'should raise an error when true' do
        Bail.raise_on_error = true

        expect {
          Bail.when_any(:nil, nil)
        }.to raise_error
      end

      it 'should return a boolean result when false' do
        Bail.raise_on_error = false

        expect {
          Bail.when_any(:nil, nil)
        }.not_to raise_error

        expect(Bail.when_any(:nil, nil)).to be_true
      end
    end
  end

  describe '.when' do
    it 'allows passing in a block as the condition test' do
      r = Bail.when(:none, 1, 2, 3) { |x| x.nil? }
      expect(r).to be_true
    end
  end

  describe '.when_any' do
    context 'using a lambda as the condition' do
      it 'raises an error when any item is true' do
        Bail.raise_on_error = true

        expect {
          Bail.when_any(->(x){x.nil?}, 1, nil, 3)
        }.to raise_error
      end
    end

    context 'using a symbol as the condition' do
      it 'raises an error when any item is true' do
        Bail.raise_on_error = true

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
      it 'allows passing a type constraint along with the condition test' do
        r = Bail.when_any({is_a: String}, 1, 2, '3')
        expect(r).to be_true
      end
    end
  end

  describe '.when_all' do
    it 'returns true when all items pass the condition test' do
      r = Bail.when_all(:nil?, nil, nil, nil)
      expect(r).to be_true
    end

    it 'returns false if any item fails the condition test' do
      r = Bail.when_all(:nil?, nil, nil, 3)
      expect(r).to be_false
    end
  end

  describe '.when_one' do
    it 'returns true if exactly one item is true' do
      expect(Bail.when_one(:nil?, 1, 2, nil, 4, 5)).to be_true
    end

    it 'returns false if more than one item is true' do
      expect(Bail.when_one(:nil?, 1, 2, nil, 4, 5, nil)).to be_false
    end
  end

  describe '.when_none' do
    it 'returns true if all items FAIL the test' do
      expect(Bail.when_none(:nil?, 1, 2, 4, 5)).to be_true
    end

    it 'returns true if one or more items PASS the test' do
      expect(Bail.when_none(:nil?, 1, 2, nil, 4, 5)).to be_false
    end
  end
end
