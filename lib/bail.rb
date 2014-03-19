require 'logger'
require 'bail/version'
require 'bail/condition_parser.rb'
require 'bail/condition_tester.rb'

module Bail
  def self.when(*objects, &block)
    # TODO: why is this harcoded as :any?
    __execute(:any?, block, objects)
  end

  def self.when_any(condition, *objects)
    __execute(:any?, condition, objects)
  end

  def self.when_all(condition, *objects)
    __execute(:all?, condition, objects)
  end

  def self.__execute(type, condition, objects)
    ConditionTester.new(type).run(ConditionParser.new(condition), objects)
  rescue ArgumentError => e
    if not Bail.suppress_output
      Bail.logger.warn(e.message)
    end

    if not Bail.suppress_errors
      raise e
    end
  end

  module Configuration
    attr_accessor :logger
    attr_accessor :suppress_errors
    attr_accessor :suppress_output
  end

  private_class_method :__execute

  extend Configuration

  # where the wood goes
  Bail.logger = Logger.new(STDOUT)
  # Bail.logger.level = Logger::WARN
  Bail.logger.formatter = proc do |severity, datetime, progname, msg|
    "Bail::[#{msg}]\n"
  end
end
