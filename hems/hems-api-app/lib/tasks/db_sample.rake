#   -------------------- Schema_Name DB Tasks Overrides - Start -----------------
namespace :schema_name do
  namespace :db do |ns|
    %i(drop create setup version charset).each do |task_name|
      desc %(Run command for usage)
      task task_name do
        puts "\nRun as <schema_name [mdb | edb | eho]>:db:#{task_name}"
      end
    end

    desc %(Run command for usage)
    task "environment:set" do
      puts "\nRun as <schema_name [mdb | edb | eho]>:db:environment:set"
    end

    namespace :schema do
      %i(load dump).each do |task_name|
        desc %(Run command for usage)
        task task_name do
          puts "\nRun as <schema_name [mdb | edb | eho]>:db:schema:#{task_name}"
        end
      end

      namespace :cache do
        %i(clear dump).each do |task_name|
          desc %(Run command for usage)
          task task_name do
            puts "\nRun as <schema_name [mdb | edb | eho]>:db:schema:cache:#{task_name}"
          end
        end
      end
    end

    namespace :structure do
      %i(load dump).each do |task_name|
        desc %(Run command for usage)
        task task_name do
          puts "\nRun as <schema_name [mdb | edb | eho]>:db:structure:#{task_name}"
        end
      end
    end
  end
end
#   -------------------- Schema_Name - DB Tasks Overrides - End -----------------

#   -------------------- Engine level - <schema_name> DB Tasks Overrides - Begin -----------------
namespace :engine_name do
  #   -------------------- <schema_name> DB Tasks Overrides - Begin -----------------
  namespace :schema_name do
    namespace :db do |ns|
      %i(migrate rollback seed version).each do |task_name|
        desc %(Run command for usage)
        task task_name do
          puts "\nRun as <engine_name [core | ..]>:<schema_name [mdb | edb | eho]>:db:#{task_name}"
        end
      end

      namespace :fixtures do
        desc %(Run command for usage)
        task :load do
          puts "\nRun as <engine_name [core | ..]>:<schema_name [mdb | edb | eho]>:db:fixtures:load"          
        end
      end

      namespace :migrate do
        %i(status redo up down).each do |task_name|
          desc %(Run command for usage)
          task task_name do
            puts "\nRun as <engine_name [core | ..]>:<schema_name [mdb | edb | eho]>:db:migrate:#{task_name}"
          end
        end
      end

      namespace :test do
        desc %(Run command for usage)
        task :prepare do
          puts "\nRun as <engine_name [core | ..]>:<schema_name [mdb | edb | eho]>:db:test:prepare"
        end
      end
    end
  end
  #   -------------------- <schema_name> DB Tasks Overrides - End -----------------
end
#   -------------------- Engine level - <schema_name> DB Tasks Overrides - End -----------------