module Lambent
  class ViewStore
    require 'lambent/view_store/result'

    class ViewNotFoundError < StandardError ; end

    def initialize(path)
      @path = path
    end

    def find_one(klass, id)
      table = get_table(klass)
      row = table.first(id:id)
      self.class.get_result(row)
    end

    def self.get_result(row)
      return nil unless row

      Result.new(
        row[:id],
        ActiveSupport::JSON.decode(row[:attributes]),
        ActiveSupport::JSON.decode(row[:computed_attributes]))
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