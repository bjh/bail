require_relative 'helpers.rb'

module Bail
  module DSL
    class ConditionParser
      attr_accessor :condition

      def initialize(condition)
        @condition = condition
      end

      def test(to)
        to_lambda.call(to)
      end

    protected
      # TODO: find out if this is actually included as protected
      include Helpers

      def to_lambda
        if condition.is_a? Hash
          condition_hash_to_lambda(condition)
        else
          # Assume Symbol or String for now
          # so wrap it in a pretty dress
          question = questionable(condition)
          ->(to) { to.send(question) }
        end
      end
    end
  end
end
