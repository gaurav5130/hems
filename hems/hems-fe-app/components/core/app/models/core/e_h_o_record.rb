module Core
  class EHORecord < ApplicationRecord
    self.abstract_class = true
    establish_connection DB_EHO_CONFIG
  end
end
