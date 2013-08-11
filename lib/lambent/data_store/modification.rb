module Lambent
  class DataStore::Modification

    attr_reader :type
    attr_reader :id
    attr_reader :changes

    def initialize(type, id, changes)
      @type    = type
      @id      = id
      @changes = changes
    end
  end
end