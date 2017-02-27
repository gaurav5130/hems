namespace :seedkit do
	namespace :db do
		desc "Seed creation for dev and test"
		task :seed => :environment do
			seed_file = "#{Rails.root}/seed_kit/seeds/seeds.rb"
			load(seed_file) if File.exist?(seed_file)
		end
	end	
end