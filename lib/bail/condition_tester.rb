require_relative 'helpers.rb'

module Bail
  class ConditionTester
    include Helpers

    attr_accessor :type

    def initialize(type)
      # :any
      @type = questionable(type)
    end

    def run(condition_parser, objects)
      if objects.send(type) { |object| condition_parser.test(object) }
        raise ArgumentError.new('A condition has failed.')
      end
    end
  end
end
