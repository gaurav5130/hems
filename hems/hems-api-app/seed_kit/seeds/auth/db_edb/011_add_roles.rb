data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

Auth::Role.delete_all

open(data_file).read.each_line do |line|
	corporate_id, establishment_id, code, desc = line.chomp.split(",")
	Auth::Role.create!(corporate_id: corporate_id, establishment_id: establishment_id, 
			code: code,
			desc: desc)
end