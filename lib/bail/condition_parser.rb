require_relative 'helpers.rb'

module Bail
  class ConditionParser
    attr_accessor :condition

    def initialize(condition)
      @condition = make_callable(condition)
    end

    def test(object)
      condition.call(object)
    end

  protected
    # TODO: find out if Helpers is actually included as protected
    include Helpers

    def make_callable(condition)
      # Bail.logger.info "condition: #{condition.to_s}"
      if condition.respond_to? :call
        condition
      elsif condition.is_a? Hash
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
