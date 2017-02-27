# save mdb database settings in global var
DB_EHO_CONFIG = YAML::load(ERB.new(File.read(Rails.root.join("config","database_eho.yml"))).result)[Rails.env]