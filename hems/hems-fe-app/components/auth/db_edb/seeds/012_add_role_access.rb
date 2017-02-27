Auth::RoleAccess.delete_all

open("tools/data/seeds/auth_012_add_role_access.txt").read.each_line do |line|
	corporate_id, establishment_id, module_id, srvc_grp_id, srvc_id, access_groups = line.chomp.split(",")
	access_groups = access_groups.gsub('|', ',') unless access_groups.to_s.blank?
	Auth::RoleAccess.create!(corporate_id: corporate_id, establishment_id: establishment_id, 
			module_id: module_id,
			service_group_id: srvc_grp_id,
			service_id: srvc_id,
			access_groups: access_groups)
end