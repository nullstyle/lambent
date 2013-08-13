module Lambent
  class EntityDefinition
    class MemberAlreadyDefinedError < StandardError ; end

    attr_reader :members
    attr_reader :generated_methods

    def initialize(parent)
      @members = {}
      @parent = parent
    end

    def add_attribute(attribute)
      add_member(attribute)
    end

    private
    def add_member(member)
      raise MemberAlreadyDefinedError if @members[member.name]
      @members[member.name] = member
      member.write_methods(@parent)
    end
  end
end