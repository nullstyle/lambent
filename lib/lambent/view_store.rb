module Lambent
  class ViewStore
    class ViewNotFoundError < StandardError ; end

    def initialize(path)
      @path = path
    end

    def find_one(klass, id)
      table = get_table(klass)
      row = table.first(id:id)
      return nil unless row
      ActiveSupport::JSON.decode row[:attributes]
    end


    private
    def get_table(klass)
      table_name = klass.name.tableize.to_sym
      result = database[table_name]

      raise ViewNotFoundError unless result

      result
    end


    def database
      @database ||= Sequel.connect("sqlite://#{@path}")
    end
  end
end