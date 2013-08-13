module Lambent
  # base reflection class for attributes, data or computed.
  class Entity::Member
    attr_reader :name
    attr_reader :dependencies

    def initialize(name)
      @name = name
      @dependencies = []
    end

    def write_methods(mod)
      raise NotImplementedError, "implement in subclass"
    end

    def set_dependencies!(dependencies)
      @dependencies = dependencies
    end

  end
end