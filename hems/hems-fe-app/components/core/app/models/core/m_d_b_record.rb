module Core
  class MDBRecord < ApplicationRecord
    self.abstract_class = true
    establish_connection DB_MDB_CONFIG
  end
end
