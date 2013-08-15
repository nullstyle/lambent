module Lambent
  class EntityDefinition
    class MemberAlreadyDefinedError < StandardError ; end

    attr_reader :members

    def initialize(parent)
      @members = {}
      @parent = parent
      @dependencies_for_next_member = []
    end

    def add_attribute(attribute)
      add_member(attribute)
    end

    def add_dependency(name)
      @dependencies_for_next_member << name
    end

    def computed_attributes
      @members.values.select{|m| m.is_a?(Entity::ComputedAttribute)}
    end

    private
    def add_member(member)
      raise MemberAlreadyDefinedError if @members[member.name]
      @members[member.name] = member
      
      member.set_dependencies! @dependencies_for_next_member
      #TODO: check for circular dependencies here
      @dependencies_for_next_member = []
      
      member.write_methods(@parent)
    end
  end
end