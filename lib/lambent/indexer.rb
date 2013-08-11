module Lambent
  class Indexer

    def initialize(path)
      @path = path
    end

    def build_index(log_path)
      open(log_path, 'r').each_line do |line|
        klass_name, id, changes_json = line.split("\t")

        klass   = klass_name.constantize
        changes = ActiveSupport::JSON.decode(changes_json)

        table = get_table(klass)

        if current = table.first(id:id)
          attributes = ActiveSupport::JSON.decode(current[:attributes])
          attributes.merge!(changes)
          table.where(id:id).update(attributes: attributes.to_json)
        else
          table.insert id:id, attributes: changes.to_json
        end
      end
    end


    private
    def get_table(klass)
      table_name = klass.name.tableize.to_sym
      unless database.table_exists? table_name
        database.create_table(table_name) do
          String :id, fixed: true, size: 32, index: {unique:true}, null: false
          String :attributes, text: true, null: false
        end
      end

      database[table_name]
    end

    def database
      @database ||= Sequel.connect("sqlite://#{@path}")
    end

  end
end