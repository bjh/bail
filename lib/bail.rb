require 'logger'
require 'bail/version'
require 'bail/condition_parser.rb'
require 'bail/condition_tester.rb'
require 'bail/behavior/raise_behavior.rb'
require 'bail/behavior/return_behavior.rb'

module Bail
  class ConditionError < ArgumentError; end

  # Bail.when :all, [:of, :these] {|item| item.nil?}
  def self.when(enumerator, *objects, &block)
    execute(enumerator, block, objects)
  end

  def self.when_any(condition, *objects)
    execute(:any?, condition, objects)
  end

  def self.when_all(condition, *objects)
    execute(:all?, condition, objects)
  end

  # def self.when_one(condition, *objects)
  #   execute(:one?, condition, objects)
  # end

  # def self.when_none(condition, *objects)
  #   execute(:none?, condition, objects)
  # end

  def self.execute(type, condition, objects)
    Bail.behavior.run do
      ConditionTester.new(type).run(ConditionParser.new(condition), objects)
    end
  end

  private_class_method :execute

  module Configuration
    attr_accessor :logger
    attr_accessor :suppress_output
    attr_accessor :behavior
  end

  extend Configuration

  # where the wood goes
  Bail.logger = Logger.new(STDOUT)
  Bail.logger.level = Logger::DEBUG
  Bail.logger.formatter = proc do |severity, datetime, progname, msg|
    "Bail::[#{msg}]\n"
  end

  # handle the behavior
  def self.raise_on_error
    @@raise_on_error
  end

  def self.raise_on_error=(boolean_value)
    @@raise_on_error = boolean_value

    if boolean_value
      Bail.behavior = RaiseBehavior.new
    else
      Bail.behavior = ReturnBehavior.new
    end
  end

  # default to return true/false
  Bail.raise_on_error = true
end
