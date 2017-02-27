# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Metamodel::Module::ModuleHeader.delete_all
Metamodel::Module::ModuleServiceHeader.delete_all
Metamodel::Module::ModuleServiceDetail.delete_all

open("tools/data/seeds/modules.txt").read.each_line do |line|
	module_id, title, desc, al, base_module, ignore_auth, migration_reqd = line.chomp.split(",")
	Metamodel::Module::ModuleHeader.create!(module_id: module_id,
			title: title,
			desc: desc,
			alias: al,
			base_module: base_module,
			ignore_auth: ignore_auth,
			migration_reqd: migration_reqd)
end

open("tools/data/seeds/module_service_headers.txt").read.each_line do |line|
	module_id, service_group_id, title, desc = line.chomp.split(",")
	Metamodel::Module::ModuleServiceHeader.create!(module_id: module_id,
			service_group_id: service_group_id,
			title: title,
			desc: desc)
end

open("tools/data/seeds/module_service_details.txt").read.each_line do |line|
	module_id, service_group_id, service_id, title, desc = line.chomp.split(",")
	Metamodel::Module::ModuleServiceDetail.create!(module_id: module_id,
			service_id: service_id,
			service_group_id: service_group_id,
			title: title,
			desc: desc)
end
