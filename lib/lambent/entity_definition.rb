module Lambent
  class EntityDefinition
    class MemberAlreadyDefinedError < StandardError ; end

    attr_reader :members
    attr_reader :generated_methods

    def initialize
      @members = {}
      @generated_methods = Module.new
    end

    def add_attribute(attribute)
      add_member(attribute)
    end

    private
    def add_member(member)
      raise MemberAlreadyDefinedError if @members[member.name]
      @members[member.name] = member
      member.write_methods(@generated_methods)
    end
  end
end