task spec: ["order:mdb:db:test:prepare"]
task spec: ["order:edb:db:test:prepare"]
task spec: ["order:eho:db:test:prepare"]

namespace :order do

  #   -------------------- MDB DB Tasks Overrides - Begin -----------------
  namespace :mdb do
    namespace :db do |ns|
      %i(migrate rollback seed version).each do |task_name|
        #desc %(Runs rake order:mdb:db:#{task_name})
        task task_name do
          Rake::Task["db:#{task_name}"].invoke
        end
      end

      namespace :fixtures do
        #desc "Loads fixtures into the current environment's database. Load specific fixtures using FIXTURES=x,y. Load from subdirectory in test/fixtures using FIXTURES_DIR=z. Specify an alternative path (eg. spec/fixtures) using FIXTURES_PATH=spec/fixtures."
        task :load do
          Rake::Task['db:fixtures:load'].invoke
        end
      end

      namespace :migrate do
        %i(status redo up down).each do |task_name|
          #desc %(Runs rake order:mdb:db:migrate:#{task_name})
          task task_name do
            Rake::Task["db:migrate:#{task_name}"].invoke
          end
        end
      end

      namespace :test do
        task :prepare do
          Rake::Task['db:test:prepare'].invoke
        end
      end

      # append and prepend proper tasks to all the tasks defined here above
      ns.tasks.each do |task|
        task.enhance ['order:mdb:set_custom_config'] do
          Rake::Task['order:mdb:revert_to_original_config'].invoke
        end
      end
    end

    task :set_custom_config do
      # save current vars
      @original_config = {
        env_schema: ENV['SCHEMA'],
        config: Rails.application.config.dup
      }

      # set config variables for custom database
      ENV['SCHEMA'] = "components/order/db_mdb/schema.rb"
      Rails.application.config.paths['db'] = ["components/order/db_mdb"]
      Rails.application.config.paths['db/migrate'] = ["components/order/db_mdb/migrate"]
      Rails.application.config.paths['db/seeds.rb'] = ["components/order/db_mdb/seeds.rb"]
      Rails.application.config.paths['config/database'] = ["config/database_mdb.yml"]
    end

    task :revert_to_original_config do
      # reset config variables to original values
      ENV['SCHEMA'] = @original_config[:env_schema]
      Rails.application.config = @original_config[:config]
    end
  end
  #   -------------------- MDB DB Tasks Overrides - End -----------------
  #   -------------------- EDB DB Tasks Overrides - Begin -----------------
  namespace :edb do
    namespace :db do |ns|
      %i(migrate rollback seed version).each do |task_name|
        #desc %(Runs rake order:mdb:db:#{task_name})
        task task_name do
          Rake::Task["db:#{task_name}"].invoke
        end
      end

      namespace :fixtures do
        #desc "Loads fixtures into the current environment's database. Load specific fixtures using FIXTURES=x,y. Load from subdirectory in test/fixtures using FIXTURES_DIR=z. Specify an alternative path (eg. spec/fixtures) using FIXTURES_PATH=spec/fixtures."
        task :load do
          Rake::Task['db:fixtures:load'].invoke
        end
      end

      namespace :migrate do
        %i(status redo up down).each do |task_name|
          #desc %(Runs rake order:mdb:db:migrate:#{task_name})
          task task_name do
            Rake::Task["db:migrate:#{task_name}"].invoke
          end
        end
      end

      namespace :test do
        task :prepare do
          Rake::Task['db:test:prepare'].invoke
        end
      end

      # append and prepend proper tasks to all the tasks defined here above
      ns.tasks.each do |task|
        task.enhance ['order:edb:set_custom_config'] do
          Rake::Task['order:edb:revert_to_original_config'].invoke
        end
      end
    end

    task :set_custom_config do
      # save current vars
      @original_config = {
        env_schema: ENV['SCHEMA'],
        config: Rails.application.config.dup
      }

      # set config variables for custom database
      ENV['SCHEMA'] = "components/order/db_edb/schema.rb"
      Rails.application.config.paths['db'] = ["components/order/db_edb"]
      Rails.application.config.paths['db/migrate'] = ["components/order/db_edb/migrate"]
      Rails.application.config.paths['db/seeds.rb'] = ["components/order/db_edb/seeds.rb"]
      Rails.application.config.paths['config/database'] = ["config/database_edb.yml"]
    end

    task :revert_to_original_config do
      # reset config variables to original values
      ENV['SCHEMA'] = @original_config[:env_schema]
      Rails.application.config = @original_config[:config]
    end
  end
  #   -------------------- EDB DB Tasks Overrides - End -----------------
  #   -------------------- EHO DB Tasks Overrides - Begin -----------------
  namespace :eho do
    namespace :db do |ns|
      %i(migrate rollback seed version).each do |task_name|
        #desc %(Runs rake order:mdb:db:#{task_name})
        task task_name do
          Rake::Task["db:#{task_name}"].invoke
        end
      end

      namespace :fixtures do
        #desc "Loads fixtures into the current environment's database. Load specific fixtures using FIXTURES=x,y. Load from subdirectory in test/fixtures using FIXTURES_DIR=z. Specify an alternative path (eg. spec/fixtures) using FIXTURES_PATH=spec/fixtures."
        task :load do
          Rake::Task['db:fixtures:load'].invoke
        end
      end

      namespace :migrate do
        %i(status redo up down).each do |task_name|
          #desc %(Runs rake order:mdb:db:migrate:#{task_name})
          task task_name do
            Rake::Task["db:migrate:#{task_name}"].invoke
          end
        end
      end

      namespace :test do
        task :prepare do
          Rake::Task['db:test:prepare'].invoke
        end
      end

      # append and prepend proper tasks to all the tasks defined here above
      ns.tasks.each do |task|
        task.enhance ['order:eho:set_custom_config'] do
          Rake::Task['order:eho:revert_to_original_config'].invoke
        end
      end
    end

    task :set_custom_config do
      # save current vars
      @original_config = {
        env_schema: ENV['SCHEMA'],
        config: Rails.application.config.dup
      }

      # set config variables for custom database
      ENV['SCHEMA'] = "components/order/db_eho/schema.rb"
      Rails.application.config.paths['db'] = ["components/order/db_eho"]
      Rails.application.config.paths['db/migrate'] = ["components/order/db_eho/migrate"]
      Rails.application.config.paths['db/seeds.rb'] = ["components/order/db_eho/seeds.rb"]
      Rails.application.config.paths['config/database'] = ["config/database_eho.yml"]
    end

    task :revert_to_original_config do
      # reset config variables to original values
      ENV['SCHEMA'] = @original_config[:env_schema]
      Rails.application.config = @original_config[:config]
    end
  end
  #   -------------------- EHO DB Tasks Overrides - End -----------------
end