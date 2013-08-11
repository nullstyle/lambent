module Lambent
  class DataStore
    require 'lambent/data_store/modification'

    def initialize(path)
      @path = path
    end

    def write_modification(modification)
      with_journal do |journal|
        changes_json = modification.changes.to_json
        journal.puts "#{modification.type}\t#{modification.id}\t#{changes_json}"
      end
    end

    private
    def with_journal(&block)
      open(@path, 'a', &block)
    end
  end
end