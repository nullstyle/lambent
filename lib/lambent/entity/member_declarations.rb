module Lambent
  module Entity::MemberDeclarations
    extend ActiveSupport::Concern

    module ClassMethods

      def attribute(*args, &block)
        attribute = if block.nil?
                       Entity::Attribute.new(*args, &block)
                    else
                       Entity::ComputedAttribute.new(*args, &block) #TODO
                     end

        entity_definition.add_attribute attribute
      end

      def scope(*args)      ; end
      def scope_with_foo(*args) ; puts "here" ; end
      def view(*args)       ; end
        

      # association methods
      def has_many(*args)   ; end
      def belongs_to(*args) ; end
      def has_one(*args)    ; end
      


      # 
      # Declared a dependency for the next defined member on the 
      # @param  name [type] [description]
      # 
      # @return [type] [description]
      def depends_on(name)
        entity_definition.add_dependency name
      end
    end
  end
end