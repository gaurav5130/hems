module Core
  class Engine < ::Rails::Engine
    isolate_namespace Core
  end

  # Don't have prefix method return anything.
  # This will keep away Rails Engine from generating all table prefixes with the engines name
  def self.table_name_prefix
  end
end
