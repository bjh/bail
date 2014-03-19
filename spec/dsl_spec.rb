require 'spec_helper'
require 'bail.rb'

Bail.suppress_output = false

class BailUsage
  def one(wants_string)
    Bail.when_any({is_a: String}, wants_string)

    :should_no_be_here
  end
end

describe 'using Bail as a DSL' do
  subject { BailUsage.new }

  describe 'one' do
    it 'shits all over itself' do
      expect(subject.one(1)).to raise_error
    end
  end
end
