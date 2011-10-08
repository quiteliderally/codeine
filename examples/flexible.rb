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


container_foo = Codeine.container_for(FooModule)
container_foo.register(:logger){"the fancy logger for FooModule"}

container_bar = Codeine.container_for(BarModule)
container_bar.register(:logger){"the simple logger for BarModule"}


FooModule::A.new 
BarModule::A.new
