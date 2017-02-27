#require_dependency "components/core/m_d_b_record"

app_namespace = namespace :app do
	desc "Install application"
	task :install => :environment do
		app_namespace["figaro:install"].invoke
		app_namespace["db:install"].invoke
#		app_namespace["db:pre_migrate"].invoke
	end

	namespace :figaro do
		task :install do |t|
  			#Bundler.with_clean_env do
	        	#system("bundle exec figaro install")
      		#end
    	end
	end

	namespace :db do
		task :install do
			Rake::Task["mdb:db:create"].invoke
			Rake::Task["edb:db:create"].invoke
			Rake::Task["eho:db:create"].invoke
		end

		# task :pre_migrate do
		# 	sql = File.open("prod_kit/prod_data/sql/db_mdb/pre_migrate.sql").read
		# 	sql.split(';').each do |sql_statement|
		# 		result = Core::MDBRecord.connection.execute(sql)
		# 		puts result.to_s.inspect
		# 	end
		# end
	end
end