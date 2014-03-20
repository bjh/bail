require 'spec_helper'
require 'bail.rb'

describe Bail::Configuration do
  describe '.suppress_errors' do
    context 'when true' do
      before :all do
        Bail.suppress_errors = true
      end

      after :all do
        Bail.suppress_errors = false
      end

      it 'suppresses the raise error behavior' do
        expect {
          Bail.when(:any, 1, 2, 3, nil) do |x|
            x.nil?
          end
        }.not_to raise_error
      end
    end
  end
end
