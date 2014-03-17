require_relative 'dsl/condition_parser.rb'

module Bail
  module DSL

    def self.when_any(condition, *objects)
      condition = ConditionParser.new(condition)

      if objects.any? { |object| condition.test(object) }
        raise ArgumentError.new('A condition test has failed.')
      end
    end

  end
end
