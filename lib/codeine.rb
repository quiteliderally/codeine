require "codeine/version"
require "codeine/container"
require "codeine/injectable"
require "codeine/containable"

module Codeine
  class << self
   
    #automatically called later in this file
    def activate()
      Module.send(:include, Codeine::Containable)
      Class.send(:include, Codeine::Injectable)
    end

    def container_for(mod)
      mod.codeine_container ||= Container.new
    end

    def default_container
      @default_container ||= Container.new
    end

    def register(service, &block)
      default_container.register(service, &block)
    end

    def get(service)
      default_container.get(service)
    end
    alias :[] :get

  end

  module Utility
    class << self
      def constant_path(constant)
        constants = []
        parts = constant.to_s.split("::")
        parts.count.times do |i|
          constants <<  parts[0..i].inject(Kernel) do |memo, obj|
            memo.const_get(obj)
          end
        end
        constants
      end

      def nearest_container(constant)
        container = nil
        constant_path(constant).reverse.each do |c|
          next unless c.respond_to? :codeine_container
          break if container = c.codeine_container
        end
        container || ::Codeine.default_container
      end
    end
  end
end

Codeine.activate
