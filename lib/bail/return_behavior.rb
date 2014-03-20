require_relative 'behavior.rb'

module Bail
  class ReturnBehavior < Behavior

    attr_accessor :result

    def run(&block)
      yield block
      result = false
    rescue Bail::ConditionError => e
      result = true

      if not Bail.suppress_output
        Bail.logger.warn(e.message)
      end
    ensure
      return result
    end
  end
end
