app_namespace = namespace :app do
	namespace :db do
		desc "Migrate application"
		task :migrate => :environment do
		    %i(metamodel).each do |mod|
		        sh "rails #{mod}:mdb:db:migrate"
		        # Rake::Task["#{mod}:mdb:db:migrate"].invoke
		    end

		    %i(auth bill facility items order reference tax_charge).each do |mod|
		        sh "rails #{mod}:edb:db:migrate"
		        #Rake::Task["#{mod}:edb:db:migrate"].invoke
		    end
		end
	end
end