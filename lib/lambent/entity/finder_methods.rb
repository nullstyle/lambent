module Lambent
  module Entity::FinderMethods
    extend ActiveSupport::Concern

    module ClassMethods

      def find(id, view_store=Lambent::Session.current_view_store)
        result = view_store.find_one(self, id)
        return nil unless result
        new_from_viewstore(result)
      end

    end
  end
end