module Lambent
  # base reflection class for attributes, data or computed.
  class Entity::Member
    attr_reader :name

    def initialize(name)
      @name = name
    end

  end
end