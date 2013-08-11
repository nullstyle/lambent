module Lambent
  module Entity::MemberDeclarations
    extend ActiveSupport::Concern

    module ClassMethods

      def attribute_with_lambent(*args)
        attribute_without_lambent(*args)
      end

      def scope(*args)      ; end
      def scope_with_foo(*args) ; puts "here" ; end
      def view(*args)       ; end
        

      # association methods
      def has_many(*args)   ; end
      def belongs_to(*args) ; end
      def has_one(*args)    ; end
        
    end
  end
end