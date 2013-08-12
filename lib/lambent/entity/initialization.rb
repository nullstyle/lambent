module Lambent
  module Entity::Initialization
    extend ActiveSupport::Concern


    def initialize(attributes={})
      self.attributes = attributes
    end

  end
end