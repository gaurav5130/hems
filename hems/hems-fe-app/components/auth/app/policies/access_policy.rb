require_dependency "core/e_d_b_record"

class AccessPolicy < Struct.new(:access_ctxt, :record)
	def check?
		#Step 1: Validate Access Context
		unless access_ctxt.valid?
			mesg = ''
			access_ctxt.errors.each { |attr, msg|
				mesg += "#{attr} : #{msg} \n"
			}
			#TODO - raise new Error
			raise Pundit::NotAuthorizedError, "invalid access context - " + mesg
		end

		#Step 2: Prior to any validation, mandatory to check if action is mapped with service access key
		action = access_ctxt.action
		access_key = access_ctxt.access_key

		#Step 3: Skip if service access key is 'skip'
		if '_skip'.eql?(access_key)
			return true
		end

		#Step 4: Retrieve module id, service group id, service id, combined key
		mid, sgid, sid = fetch_id(access_key)

		#Step 5: License Checks
		#TODO - Check if module id is licensed to cid and eid

		#Step 6: Check if authorization ignored for module
		#TODO - Check ignore_auth flag for the module id

		#Step 7: Check if user is authorized to perform operation as per access key
		user_role = access_ctxt.user.role
		context = access_ctxt.context
		sql = "select count(*) as count
			from e_schema.role_access 
			where (',' || access_groups::text || ',') LIKE '%,#{user_role},%' 
				and corporate_id = '#{context.corporate_id}'
				and establishment_id = '#{context.establishment_id}'
				and module_id = '#{mid}'
				and service_group_id ='#{sgid}'
				and service_id = '#{sid}'"

		result = Core::EDBRecord.connection.execute(sql)
		row = result.rows.first
		count = row.first
		unless count == 1
			raise Pundit::NotAuthorizedError, "You are not authorized to perform this action."
		end

		true
	end

	private

	def fetch_id(access_key)
		access_key = access_key.strip.upcase
		mid, sgid, sid = access_key.chomp.split(".")
		unless mid
			raise Pundit::NotAuthorizedError, "missing module id in access key"
		end
		unless sgid
			sgid = 'ROOT'
		end
		unless sid
			sid = 'ROOT'
		end

		return mid, sgid, sid
	end
end