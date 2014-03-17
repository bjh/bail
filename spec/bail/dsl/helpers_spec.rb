require 'spec_helper'
require 'bail/dsl/helpers.rb'

describe Bail::DSL::Helpers do
  subject { Object.new.extend(Bail::DSL::Helpers) }

  describe '.questionable' do
    context 'when the condition already has a `?` on the end' do
      it 'returns the condition unchanged' do
        expect(subject.questionable(:is_a?)).to eq :is_a?
      end
    end

    context 'when the condition does not have a `?` on the end' do
      it 'returns the condition with a ? on the end' do
        expect(subject.questionable(:is_a)).to eq :is_a?
      end
    end
  end

  describe '.condition_hash_to_lambda' do
    it 'returns a lambda' do
      f = subject.condition_hash_to_lambda(is_a: String)
      expect(f).to be_a Proc
    end
  end
end
