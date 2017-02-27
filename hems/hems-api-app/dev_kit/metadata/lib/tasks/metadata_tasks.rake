namespace :metadata do
	namespace :reference do
		desc "Creating metadata seed and dumping to DB" 
		task :create, [:ref_type] do |t,args|
			require "json-schema"
			def abort_task
				p "Rake Aborted!"
				exit
			end

			def open_truncate_seed_file
				p "Creating/Opening Seed file - reference_seeds.rb"
				@seed_file = open("#{Rails.root}/components/metamodel/db_mdb/seeds/reference/reference_seeds.rb", "w")
				p "Truncating Seed File"
				@seed_file.truncate(0)
				p "Seed File Truncated"
			end

			def validate_json_structure ref_json
				schema_file = "#{Rails.root}/dev_kit/metadata/data/reference/schema/schema.json"
				schema  = File.read(schema_file)
				error_arr = JSON::Validator.fully_validate(schema, ref_json)
				if error_arr.length > 0
					p "Validation Fails"
					p "Errors are following"
					p error_arr
					abort_task
				end
			end

			def validate_json_business ref_type , ref_json
				if ref_type == "default_type"
					if(ref_json[ref_type]["header"].length >0 || ref_json[ref_type]["ref_fields"].length == 0 || ref_json[ref_type]["additional_fields"].length >0)
						p "default_type.json is not having valid structure"
						abort_task
					end
				else
					if(ref_json[ref_type]["header"].length >0)
						if (ref_json[ref_type]["header"]["overridden_fields"] == true && ref_json[ref_type]["ref_fields"].length == 0)
							p "In #{ref_type}.json overridden fields is true but not defined"
							abort_task
						elsif (ref_json[ref_type]["header"]["overridden_fields"] == false && ref_json[ref_type]["ref_fields"].length > 0)
							p "In #{ref_type}.json overridden fields is false but defined"
							abort_task
						elsif (ref_json[ref_type]["header"]["additional_fields"] == true && ref_json[ref_type]["additional_fields"].length == 0)
							p "In #{ref_type}.json additional fields is true but not defined"
							abort_task
						elsif (ref_json[ref_type]["header"]["additional_fields"] == false && ref_json[ref_type]["additional_fields"].length > 0)
							p "In #{ref_type}.json additional fields is false but defined"
							abort_task
						end
					else
						p "#{ref_type}.json is not having header data"
						abort_task
					end
				end
			end

			def validate_and_prepare ref_type, filename
				p "File picked #{filename}"
				p "Reference type -> #{ref_type}"
				p "Reading JSON file -> #{ref_type}.json"
				json_file_content = File.read(filename)
				p "Parsing JSON"
				begin
					ref_json = JSON.parse(json_file_content)
				rescue JSON::ParserError
					p "JSON Parsing error"
					abort_task
				end
				if !(ref_json.key?(ref_type))
					p "JSON key name and file name does not match"
					abort_task
				end

				p "Validating JSON Structure"
				validate_json_structure ref_json
				p "Validated JSON Structure"
				p" Validating JSON Business Logic"
				validate_json_business ref_type,ref_json
				p "Validated JSON Business Logic"
				p "Clear Validation :)"

				@line += "Metamodel::Reference::RefFields.where(ref_type: '#{ref_type}').delete_all"
				@line += "\n\n"
				@line += "Metamodel::Reference::RefHeader.where(ref_type: '#{ref_type}').delete_all"
				@line += "\n\n"

				p "Lines inserted for deleting #{ref_type} Header and Fields row"

				if ref_json[ref_type]["header"].length > 0
					@line += "Metamodel::Reference::RefHeader.create("
					@line += "ref_type: '#{ref_type}', "
					ref_json[ref_type]["header"].each do |column,value|
						if column == "overridden_fields" || column == "additional_fields"
							@line += "#{column}: #{value}, "
						else
							@line += "#{column}: '#{value}', "
						end
					end
					@line += ")"
					@line += "\n\n"
				end

				ref_json[ref_type]["ref_fields"].each do |field,data|
					@line += "Metamodel::Reference::RefFields.create("
					@line += "ref_type: '#{ref_type}', "
					@line += "fld_name: '#{field}', "
					data.each do |column,value|
						if value != ""
							if column == "fld_size" || column == "editable"
								@line += "#{column}: #{value}, "
							else
								@line += "#{column}: '#{value}', "
							end
						end
					end
					@line += "is_additional: false"
					@line += ")"
					@line += "\n\n"
				end

				ref_json[ref_type]["additional_fields"].each do |field,data|
					@line += "Metamodel::Reference::RefFields.create("
					@line += "ref_type: '#{ref_type}', "
					@line += "fld_name: '#{field}', "
					data.each do |column,value|
						if value != ""
							if column == "fld_size" || column == "editable"
								@line += "#{column}: #{value}, "
							else
								@line += "#{column}: '#{value}', "
							end
						end
					end
					@line += "is_additional: true"
					@line +=  ")"
					@line += "\n\n"
				end
				p "Lines written for #{ref_type}"
			end

			def write_and_close_file
				p "Writing the following lines in reference_seeds.rb"
				p "================================================="
				p @line
				p "================================================="
				@seed_file.write(@line)
				p "Lines written in file"
				p "Closing File"
				@seed_file.close
				p "File Closed" 
			end

			if args[:ref_type].nil?
				p "Argument Empty"
				next
			elsif args[:ref_type] == "all"
				p "Task for all"
				@line = ""
				Dir[File.join(Rails.root,'dev_kit', 'metadata','data','reference','*_type.json')].each do |filename|
					p "----------------------------------------------"
					flnm = File.basename(filename,'.json')
					ref_type = flnm
					#ref_type = flnm.chomp("_type")
					validate_and_prepare(ref_type,filename)
					p "----------------------------------------------"
				end
				open_truncate_seed_file
				write_and_close_file
			else
				ref_type = args[:ref_type]
				p "Task for #{ref_type}"
				filename = "#{Rails.root}/dev_kit/metadata/data/reference/#{ref_type}_type.json"
				@line = ""
				validate_and_prepare ref_type,filename
				open_truncate_seed_file
				write_and_close_file
			end
			Rake::Task['db:seed:seeds'].invoke
		end
	end
end

namespace :db do
	namespace :seed do
		task :seeds => :environment do
			p "Loading file reference_seeds.rb"
			filename = "#{Rails.root}/components/metamodel/db_mdb/seeds/reference/reference_seeds.rb"
			load(filename) if File.exist?(filename)
			p "File loaded"
			p "Dumping to database"
			p "Dumped"
		end
	end
end