# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

raise "\nENGINE parameter is required.\nUsage :- seedkit:db:seed ENGINE=<engine name> DB=<db name> [VERSION=<ver num>]\n\n" if ENV['ENGINE'].to_s.empty?
raise "\nDB parameter is required.\nUsage :- seedkit:db:seed ENGINE=<engine name> DB=<db name> [VERSION=<ver num>]\n\n" if ENV['DB'].to_s.empty?

file_dir = File.join(File.dirname(__FILE__), "#{ENV['ENGINE']}", "db_#{ENV['DB']}")
unless File.directory?(file_dir)
	raise "\nInvalid file directory - '#{file_dir.to_s}'\n\n"
end

if ENV['VERSION'].present?
  seed_files = Dir[File.join(file_dir.to_s, "#{ENV['VERSION']}*.rb")]
  raise "No seed files found matching '#{ENV['VERSION']}' in directory - '#{file_dir.to_s}'" if seed_files.empty?
else
  seed_files = Dir[File.join(file_dir.to_s, '*.rb')]
end

seed_files.sort_by{|f| File.basename(f).to_i}.each do |file|
  	require File.join(file_dir.to_s, File.basename(file, File.extname(file)))
end