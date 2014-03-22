
module Bail
  class Behavior
  protected
    def run(&block)
      raise 'override me or you will be trampled by unicorns!'
    end
  end
end
