module Lambent
  # base reflection class for attributes, data or computed.
  class Entity::Attribute < Entity::Member

    def initialize(name, type, options={})
      super name
      @type = type
      @default = options.delete(:default)
    end

    def get(instance)
      unless instance.instance_variable_defined? instance_variable_name
        new_value = default_value(instance)
        instance.changed_attributes[@name] = nil
        instance.instance_variable_set(instance_variable_name, new_value)
      end

      instance.instance_variable_get(instance_variable_name)
    end

    def set(instance, value)
      instance.__send__(:"#{@name}_will_change!")
      instance.instance_variable_set(instance_variable_name, value)
    end

    def default_value(instance)
      if @default.respond_to? :call
        @default.call
      else
        @default
      end
    end
    
    def write_methods(mod)
      attribute = self
      name      = @name

      mod.class_eval do
        define_method(name){ attribute.get(self) }
        define_method(:"#{name}="){ |value| attribute.set(self, value) }

        define_attribute_methods name
      end

    end

    private
    def instance_variable_name
      @instance_variable_name ||= "@_#{@name}_"
    end
  end
end