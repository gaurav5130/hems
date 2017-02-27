app_namespace = namespace :app do
	desc "Annotate application"
	task :annotate => :environment do
	    list = ''
	    %i(auth bill facility items metamodel order reference tax_charge).each do |mod|
	        sh "annotate --model-dir components/#{mod}/app/models"
	    end
	    sh "annotate --routes"
	end
end