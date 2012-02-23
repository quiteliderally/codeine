
module Codeine
  class Container
    
    def services
      @services ||= {}
    end

    def filters
      @filters ||= []
    end

    def register(key, &block)
      services[key.to_sym] = block
    end

    def get(key, args = [])
      key = key.to_sym
      service = services[key].call(*args)
      filters.each do |f|
        if key.to_s =~ f[:pattern]
          f[:block].call(key, service)
        end
      end
      service
    end
    alias :[] :get

    def filter(pattern, &block)
      filters.push :pattern => pattern, :block => block
    end

    def configure
      yield self
    end
  end
end
