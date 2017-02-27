data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

Reference::RefCodes.where(ref_type: 'tax_component_type').delete_all

open(data_file).read.each_line do |line|
	corporate_id, establishment_id, ref_type, code, short_desc = line.chomp.split(",")
	Reference::RefCodes.create!(corporate_id: corporate_id,
			establishment_id: establishment_id,
			ref_type: ref_type,
			code: code,
			desc: short_desc,
			alt_desc: short_desc,
			short_desc: short_desc)
end