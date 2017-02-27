require 'rails/generators/active_record/migration/migration_generator'

class FacilityMdbMigrationGenerator < ActiveRecord::Generators::MigrationGenerator
  source_root File.join(File.dirname(ActiveRecord::Generators::MigrationGenerator.instance_method(:create_migration_file).source_location.first), "templates")

  def create_migration_file
  	# Number of dot.dot's (..) are based on generator files to arrive at app root directory
  	app_dir = File.absolute_path(File.dirname(__FILE__) + "/../../../..")
  	unless app_dir.match Dir.pwd
  		raise "Generation needs to run from directory [#{app_dir}]\n"
  	end

    set_local_assigns!
    validate_file_name!
    migration_template @migration_template, "components/facility/db_mdb/migrate/#{file_name}.rb"
  end
end