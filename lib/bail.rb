require 'bail/version'
require 'bail/condition_parser.rb'
require 'bail/condition_tester.rb'

module Bail
  def self.when(*objects, &block)
    __harness do
      __execute(:any?, block, objects)
    end
  end

  def self.when_any(condition, *objects)
    __harness do
      __execute(:any?, condition, objects)
    end
  end

  def self.when_all(condition, *objects)
    __harness do
      __execute(:all?, condition, objects)
    end
  end

  def self.__execute(type, condition, objects)
    ConditionTester.new(type).run(ConditionParser.new(condition), objects)
  end

  def self.__harness(&block)
    yield block
  rescue ArgumentError => e
    if not Bail.suppress_output
      puts "Bail [#{e.message}]"
    end

    if not Bail.suppress_errors
      raise e
    end
  end

  module Configuration
    attr_accessor :suppress_errors
    attr_accessor :suppress_output
  end

  private_class_method :__harness
  private_class_method :__execute

  extend Configuration
end
