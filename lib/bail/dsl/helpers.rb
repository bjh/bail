
module Bail
  module DSL
    module Helpers
      def questionable(condition)
        condition.to_s.gsub(/\?$/, '').gsub(/$/, '?').to_sym
      end

      def condition_hash_to_lambda(condition)
        test = questionable(condition.keys.first)
        against = condition.values.first

        ->(testee) { testee.send(test, against) }
      end
    end
  end
end
