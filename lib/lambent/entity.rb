module Lambent
  module Entity
    extend ActiveSupport::Concern
    extend ActiveSupport::Autoload

    autoload :Member
    autoload :Scope
    autoload :Attribute
    autoload :Assocation
    autoload :MemberDeclarations
    autoload :FinderMethods

    include Virtus
    include ActiveModel::Dirty
    include Entity::MemberDeclarations
    include Entity::FinderMethods


    attribute :id, String, default: ->(entity, attribute){ UUIDTools::UUID.timestamp_create.hexdigest }

    def save(data_store=Lambent::Session.current_data_store)
      m = get_modification
      data_store.write_modification m

      @previously_changed = changes
      @changed_attributes.clear
      true
    end

    private
    def get_modification
      return nil unless changed?

      changes = changed.each_with_object({}) do |key, result|
        result[key] = self[key]
      end

      modification = DataStore::Modification.new(self.class, self.id, changes)
    end
  end
end