Auth::Role.delete_all
open("tools/data/seeds/auth_011_add_roles.txt").read.each_line do |line|
	corporate_id, establishment_id, code, desc = line.chomp.split(",")
	Auth::Role.create!(corporate_id: corporate_id, establishment_id: establishment_id, 
			code: code,
			desc: desc)
end