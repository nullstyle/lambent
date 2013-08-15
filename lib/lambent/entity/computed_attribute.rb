module Lambent
  # base reflection class for attributes, data or computed.
  class Entity::ComputedAttribute < Entity::Member

    def initialize(name, type, options={}, &block)
      super name
      @type = type
      @value_block = block
    end

    def get(instance)
      instance.computed_attributes[name]
    end

    def compute(instance)
      @value_block.instance_exec(instance, &@value_block)
    end

    def write_methods(mod)
      attribute = self
      name      = @name

      mod.class_eval do
        define_method(name){ attribute.get(self) }
        define_attribute_methods name
      end

    end
  end
end