$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'codeine'


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


Codeine.configure(FooModule) do |c|
  c.register(:logger){"the fancy logger for FooModule"}
end

Codeine.configure(BarModule) do |c|
  c.register(:logger){"the simple logger for BarModule"}
end


FooModule::A.new 
BarModule::A.new
