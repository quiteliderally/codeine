
module Codeine
  module Injectable

    def nearest_codeine_container
      Codeine::Utility.nearest_container(self)
    end

    def codeine_inject(service, options = {})
      args = options.delete(:args){[]}
      method_name = options.delete(:method_name) || service
      define_method(method_name.to_sym) do |*args|
        cache = instance_variable_get("@codeine_#{service}")
        unless cache
          cache = self.class.nearest_codeine_container.get(service.to_sym, *args)
          instance_variable_set("@codeine_#{service}", cache)
        end
        cache
      end
    end

  end
end
