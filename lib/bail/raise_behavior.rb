require_relative 'behavior.rb'

module Bail
  class RaiseBehavior < Behavior
    def run(&block)
      yield block
    rescue Bail::ConditionError => e
      if not Bail.suppress_output
        Bail.logger.warn(e.message)
      end

      raise e
    end
  end
end
