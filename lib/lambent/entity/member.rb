module Lambent
  # base reflection class for attributes, data or computed.
  class Entity::Member
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def write_methods(mod)
      raise NotImplementedError, "implement in subclass"
    end

  end
end