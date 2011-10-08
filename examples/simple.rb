$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'codeine'

Codeine.activate
Codeine.register(:logger){"some logger"}

module FooModule
  class A
    codeine_inject :logger
    def initialize
      puts logger.inspect
    end
  end
end

module BarModule
  class A
    codeine_inject :logger
    def initialize
      puts logger.inspect
    end
  end
end

FooModule::A.new
BarModule::A.new
