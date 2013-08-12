require "lambent/version"

require 'sequel'
require 'virtus'
require 'uuidtools'

require 'active_support/core_ext/module/aliasing'
require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/string/inflections'
require 'active_support/dependencies/autoload'
require 'active_support/concern'
require 'active_support/json'

require 'active_model'
require 'active_model/attribute_methods'
require 'active_model/dirty'

require 'lambent/virtus_ext/attribute/dirty'
require 'lambent/virtus_ext/extensions/lambent'

module Lambent
  extend ActiveSupport::Autoload

  autoload :Entity
  autoload :EntityDefinition
  autoload :DataStore
  autoload :ViewStore
  autoload :Indexer
  autoload :Session

  # true when we are in the view generation process
  def self.generating_view?
    false
  end

end
