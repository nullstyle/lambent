module Lambent
  module Entity::Initialization
    extend ActiveSupport::Concern


    def initialize(attributes={})
      self.attributes = attributes
    end

    module ClassMethods
      def new_from_viewstore(viewstore_result)
        return nil unless viewstore_result
        inst                     = new
        inst.id                  = viewstore_result.id
        inst.attributes          = viewstore_result.attributes
        inst.computed_attributes = viewstore_result.computed_attributes.symbolize_keys
        inst.loaded_from_db!
      end
    end

  end
end