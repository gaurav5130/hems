module Bill
  class Engine < ::Rails::Engine
    isolate_namespace Bill
    config.generators.api_only = true
  end

  # Don't have prefix method return anything.
  # This will keep away Rails Engine from generating all table prefixes with the engines name
  def self.table_name_prefix
  end
end
