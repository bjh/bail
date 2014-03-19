require 'logger'
require 'bail/version'
require 'bail/condition_parser.rb'
require 'bail/condition_tester.rb'

module Bail
  class ConditionError < ArgumentError; end

  def self.when(*objects, &block)
    # TODO: why is this harcoded as :any?
    execute(:any?, block, objects)
  end

  def self.when_any(condition, *objects)
    execute(:any?, condition, objects)
  end

  def self.when_not_any(condition, *objects)
    execute_not(:any?, condition, objects)
  end

  def self.when_all(condition, *objects)
    execute(:all?, condition, objects)
  end

  def self.when_not_all(condition, *objects)
    execute_not(:all?, condition, objects)
  end

  def self.harness(&block)
    yield block
  rescue Bail::ConditionError => e
    if not Bail.suppress_output
      Bail.logger.warn(e.message)
    end

    if not Bail.suppress_errors
      raise e
    end
  end

  def self.execute(type, condition, objects)
    harness do
      ConditionTester.new(type).run(ConditionParser.new(condition), objects)
    end
  end

  def self.execute_not(type, condition, objects)
    harness do
      ConditionTester.new(type).run(ConditionParser.new(condition), objects)
    end
  end

  module Configuration
    attr_accessor :logger
    attr_accessor :suppress_errors
    attr_accessor :suppress_output
  end

  private_class_method :execute, :harness

  extend Configuration

  # where the wood goes
  Bail.logger = Logger.new(STDOUT)
  Bail.logger.level = Logger::DEBUG
  Bail.logger.formatter = proc do |severity, datetime, progname, msg|
    "Bail::[#{msg}]\n"
  end
end
