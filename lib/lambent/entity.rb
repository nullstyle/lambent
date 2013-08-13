module Lambent
  module Entity
    extend ActiveSupport::Autoload
    extend ActiveSupport::Concern

    autoload :Member
    autoload :Scope
    autoload :Attribute
    autoload :Assocation
    autoload :MemberDeclarations
    autoload :FinderMethods
    autoload :Initialization

    include ActiveModel::AttributeMethods
    include ActiveModel::Dirty
    include Entity::MemberDeclarations
    include Entity::FinderMethods
    include Entity::Initialization

    included do
      class_attribute :entity_definition
      self.entity_definition = EntityDefinition.new(self)

      attribute :id, String, default: -> { UUIDTools::UUID.timestamp_create.hexdigest }
    end



    def save(data_store=Lambent::Session.current_data_store)
      m = get_modification
      data_store.write_modification m

      @previously_changed = changes
      @changed_attributes.clear
      true
    end

    def loaded_from_db!
      @changed_attributes.clear
      self
    end

    def attributes=(attributes)
      attributes.each do |key, value|
        self.__send__ "#{key}=", value
      end
    end

    private
    def get_modification
      return nil unless changed?

      changes = changed.each_with_object({}) do |key, result|
        result[key] = self.__send__ key
      end

      modification = DataStore::Modification.new(self.class, self.id, changes)
    end
  end
end