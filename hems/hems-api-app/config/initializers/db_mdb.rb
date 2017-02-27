# save mdb database settings in global var
DB_MDB_CONFIG = YAML::load(ERB.new(File.read(Rails.root.join("config","database_mdb.yml"))).result)[Rails.env]