module Core
  class EDBRecord < ApplicationRecord
    self.abstract_class = true
    establish_connection DB_EDB_CONFIG
  end
end
