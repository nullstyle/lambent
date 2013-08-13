module Lambent
  # base reflection class for attributes, data or computed.
  class Entity::ComputedAttribute < Entity::Member

    def initialize(name, type, options={}, &block)
      super name
      @type = type
      @value_block = block
    end

    def get(instance)
      unless instance.instance_variable_defined? instance_variable_name
        new_value = default_value(instance)
        instance.changed_attributes[@name] = nil
        instance.instance_variable_set(instance_variable_name, new_value)
      end

      instance.instance_variable_get(instance_variable_name)
    end

    def write_methods(mod)
      attribute = self
      name      = @name

      mod.class_eval do
        define_method(name){ attribute.get(self) }
        define_attribute_methods name
      end

    end

    private
    def instance_variable_name
      @instance_variable_name ||= "@_#{@name}_"
    end
  end
end