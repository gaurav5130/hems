data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

Auth::RoleAccess.delete_all

open(data_file).read.each_line do |line|
	corporate_id, establishment_id, module_id, srvc_grp_id, srvc_id, access_groups = line.chomp.split(",")
	access_groups = access_groups.gsub('|', ',') unless access_groups.to_s.blank?
	Auth::RoleAccess.create!(corporate_id: corporate_id, establishment_id: establishment_id, 
			module_id: module_id,
			service_group_id: srvc_grp_id,
			service_id: srvc_id,
			access_groups: access_groups)
end