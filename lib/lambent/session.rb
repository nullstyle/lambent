require 'fileutils'

module Lambent
  class Session

    def self.current
      Thread.current[:lambent_session]
    end

    def self.current_data_store
      current.try :data_store
    end

    def self.current_view_store
      current.try :view_store
    end

    def self.with_session(session)
      prev_session = current
      Thread.current[:lambent_session] = session
      yield if block_given?
    ensure
      Thread.current[:lambent_session] = prev_session
    end

    attr_reader :base_path
    attr_reader :data_store
    attr_reader :view_store
    attr_reader :indexer

    def initialize(base_path)
      @base_path  = base_path
      FileUtils.mkdir_p base_path

      @data_store = DataStore.new(data_store_path)
      @view_store = ViewStore.new(view_store_path)
      @indexer    = Indexer.new(view_store_path)
    end

    def build_index
      @indexer.build_index data_store_path
    end

    private
    def data_store_path
      @base_path + "/updates.log"
    end

    def view_store_path
      @base_path + "/indexes.db"
    end
  end
end