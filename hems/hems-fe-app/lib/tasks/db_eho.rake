task spec: ["eho:db:test:prepare"]

#   -------------------- EHO DB Tasks Overrides - Start -----------------
namespace :eho do
  namespace :db do |ns|
    %i(drop create setup version charset).each do |task_name|
      #desc %(Runs rake eho:db:#{task_name})
      task task_name do
        Rake::Task["db:#{task_name}"].invoke
      end
    end

    #desc "Set the environment value for the database"
    task "environment:set" do
      Rake::Task['db:environment:set'].invoke
    end

    namespace :schema do
      %i(load dump).each do |task_name|
        #desc %(Runs rake eho:db:schema:#{task_name})
        task task_name do
          Rake::Task["db:schema:#{task_name}"].invoke
        end
      end

      namespace :cache do
        %i(clear dump).each do |task_name|
          #desc %(Runs rake eho:db:schema:cache:#{task_name})
          task task_name do
            Rake::Task["db:schema:cache:#{task_name}"].invoke
          end
        end
      end
    end

    namespace :structure do
      %i(load dump).each do |task_name|
        #desc %(Runs rake eho:db:structure:#{task_name})
        task task_name do
          Rake::Task["db:structure:#{task_name}"].invoke
        end
      end
    end

    # append and prepend proper tasks to all the tasks defined here above
    ns.tasks.each do |task|
      task.enhance ['eho:set_custom_config'] do
        Rake::Task['eho:revert_to_original_config'].invoke
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
    ENV['SCHEMA'] = "db_eho/schema.rb"
    Rails.application.config.paths['db'] = ["db_eho"]
    Rails.application.config.paths['db/migrate'] = ["db_eho/migrate"]
    Rails.application.config.paths['db/seeds.rb'] = ["db_eho/seeds.rb"]
    Rails.application.config.paths['config/database'] = ["config/database_eho.yml"]
  end

  task :revert_to_original_config do
    # reset config variables to original values
    ENV['SCHEMA'] = @original_config[:env_schema]
    Rails.application.config = @original_config[:config]
  end
end
#   -------------------- EHO DB Tasks Overrides - End -----------------
