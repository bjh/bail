require 'spec_helper'
require 'bail/dsl.rb'

describe Bail::DSL do
  subject { Bail::DSL }

  describe '.when_any' do
    context 'condition parameter is a symbol' do
      it 'it used the passed in symbol as the query' do
        expect {
          subject.when_any(:nil?, 1, 2, nil)
        }.to raise_error ArgumentError
      end
    end

    context 'condition parameter is a Hash' do
      it 'it used the Hash key' do
        expect {
          subject.when_any(:nil?, 1, 2, nil)
        }.to raise_error ArgumentError
      end
    end
  end
end
