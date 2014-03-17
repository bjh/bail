require 'spec_helper'
require 'bail/dsl/condition_parser.rb'

describe Bail::DSL::Helpers do
  subject { ConditionParser.new(:nil?) }

  describe '#' do
    context '' do
      it '' do
        # expect(subject.questionable(:is_a?)).to eq :is_a?
      end
    end
  end
end
