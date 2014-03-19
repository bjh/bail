
module Bail
  module Helpers
    def questionable(condition)
      # TODO: Object.new.extend(Enumerable).respond_to? condition
      condition.to_s.gsub(/\?$/, '').gsub(/$/, '?').to_sym
    end

    def condition_hash_to_lambda(condition)
      test = questionable(condition.keys.first)
      against = condition.values.first

      ->(testee) { testee.send(test, against) }
    end
  end
end
