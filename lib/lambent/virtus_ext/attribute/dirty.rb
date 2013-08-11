module VirtusExt
  module Attribute
    module Dirty
      extend ActiveSupport::Concern

      included do
        alias_method_chain :set, :dirty
      end

      def set_with_dirty(instance, value)
        instance.__send__(:"#{name}_will_change!")
        set_without_dirty(instance, value)
      end
    end
  end
end

Virtus::Attribute.send(:include, VirtusExt::Attribute::Dirty)