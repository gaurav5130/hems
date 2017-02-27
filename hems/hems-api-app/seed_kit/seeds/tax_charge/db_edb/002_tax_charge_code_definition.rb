data_file = File.join(File.dirname(__FILE__), "data", File.basename(__FILE__).gsub(".rb", ".txt"))

TaxCharge::TaxChargeCodeDefinition.delete_all

open(data_file).read.each_line do |line|
    corporate_id, code, serial_no, component_id, short_name, long_name= line.chomp.split(",")
    TaxCharge::TaxChargeCodeDefinition.create!(corporate_id: corporate_id, code: code, serial_no: serial_no,component_id: component_id, short_name: short_name, long_name: long_name)
end