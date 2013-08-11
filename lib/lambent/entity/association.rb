module Lambent
  # base reflection class for attributes, data or computed.
  class Entity::Association < Entity::Member

    def initialize(name, type)
      super @name
      @type = type
    end

  end
end