require 'spec_helper'
require 'bail.rb'

describe Bail::Configuration do
  describe '.catch_errors' do
    context 'when true' do
      before :all do
        Bail.suppress_errors = true
      end

      after :all do
        Bail.suppress_errors = false
      end

      it 'does not raise an exception' do
        expect {
          Bail.when(nil, 3, 3) do |x|
            x.nil?
          end
        }.not_to raise_error
      end
    end
  end
end
