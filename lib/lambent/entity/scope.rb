module Lambent

  class Entity::Attribute < Entity::Member

    def initialize(name, filter)
      super name
      @type   = type
      @filter = filter
    end
  end

end