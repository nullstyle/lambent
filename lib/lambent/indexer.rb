module Lambent
  class Indexer

    def initialize(path)
      @path = path
    end

    def build_index(log_path)
      write_attributes_index(log_path)
      write_computed_attributes
    end


    private
    
    def write_attributes_index(log_path)
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
          table.insert id:id, attributes: changes.to_json, computed_attributes: {}.to_json
        end
      end
    end

    def write_computed_attributes
      Entity.all_types.each do |entity_klass|
        table = get_table(entity_klass)
        table.each do |row|
          vs = Lambent::ViewStore.get_result(row)
          inst = entity_klass.new_from_viewstore(vs)
          computed_attributes = inst.build_computed_attributes
          table.where(id:row[:id]).update(computed_attributes: computed_attributes.to_json)
        end
      end 
    end


    def get_table(klass)
      table_name = klass.name.tableize.to_sym
      unless database.table_exists? table_name
        database.create_table(table_name) do
          String :id, fixed: true, size: 32, index: {unique:true}, null: false
          String :attributes, text: true, null: false
          String :computed_attributes, text: true, null: false
        end
      end

      database[table_name]
    end

    def database
      @database ||= Sequel.connect("sqlite://#{@path}")
    end

  end
end