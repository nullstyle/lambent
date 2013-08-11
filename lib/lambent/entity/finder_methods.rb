module Lambent
  module Entity::FinderMethods
    extend ActiveSupport::Concern

    module ClassMethods

      def find(id, view_store=Lambent::Session.current_view_store)
        attributes = view_store.find_one(self, id)
        return nil unless attributes
        new(attributes.merge(id:id))
      end

    end
  end
end