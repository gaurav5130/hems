data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

Metamodel::Module::ModuleServiceDetail.delete_all

open(data_file).read.each_line do |line|
	module_id, service_group_id, service_id, title, desc = line.chomp.split(",")
	Metamodel::Module::ModuleServiceDetail.create!(module_id: module_id,
			service_id: service_id,
			service_group_id: service_group_id,
			title: title,
			desc: desc)
end