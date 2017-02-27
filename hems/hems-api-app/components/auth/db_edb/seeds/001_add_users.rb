Auth::Users.delete_all
open("prod_kit/prod_data/seeds/auth/db_edb/001_add_users.txt").read.each_line do |line|
	corporate_id, establishment_id, user_id, user_name = line.chomp.split(",")
	Auth::Users.create!(corporate_id: corporate_id, establishment_id: establishment_id, 
			user_id: user_id,
			user_name: user_name,
			email: 'admin@hems.com', 
            password: 'hems', 
            password_confirmation: 'hems',
            role: 'admin')
end