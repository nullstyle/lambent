module Lambent
  # base reflection class for attributes, data or computed.
  class Entity::Attribute < Entity::Member

    def initialize(name, type, options={})
      super name
      @type = type
      @default = options.delete(:default)
    end

    def get(instance)
      puts "getting #{@name} from #{instance.inspect}"
    end

    def set(instance, value)
      puts "setting #{@name} from #{instance.inspect} to #{value}"
    end
    
    def write_methods(mod)
      attribute = self
      name      = @name
      
      mod.class_eval do
        define_method(name){ attribute.get(self) }
        define_method(:"#{name}="){ |value| attribute.get(self) }
      end

    end
  end
end