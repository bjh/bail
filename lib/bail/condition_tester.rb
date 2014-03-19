require_relative 'helpers.rb'

module Bail
  class ConditionTester
    include Helpers

    attr_accessor :type

    def initialize(type)
      # can be methods from Enumerable basically
      #  i.e. :any?, :all?
      @type = questionable(type)
    end

    def run(condition_parser, objects)
      if objects.send(type) { |object| condition_parser.test(object) }
        raise ArgumentError.new('A Bail condition has failed.')
      end
    end
  end
end
