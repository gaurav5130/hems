data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

Metamodel::Module::ModuleHeader.delete_all

open(data_file).read.each_line do |line|
	module_id, title, desc, al, base_module, ignore_auth, migration_reqd = line.chomp.split(",")
	Metamodel::Module::ModuleHeader.create!(module_id: module_id,
			title: title,
			desc: desc,
			alias: al,
			base_module: base_module,
			ignore_auth: ignore_auth,
			migration_reqd: migration_reqd)
end