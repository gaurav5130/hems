# save mdb database settings in global var
DB_EDB_CONFIG = YAML::load(ERB.new(File.read(Rails.root.join("config","database_edb.yml"))).result)[Rails.env]