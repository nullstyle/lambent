module VirtusExt
  module Extensions
    module Lambent
      extend ActiveSupport::Concern

      included do
        alias_method_chain :attribute, :lambent
      end

      def attribute_with_lambent(*args)
        attribute_without_lambent(*args)
        define_attribute_methods args.first
      end
    end
  end
end

Virtus::Extensions.send(:include, VirtusExt::Extensions::Lambent)