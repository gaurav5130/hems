require_dependency "core/api/base_controller"
require_dependency "core/e_d_b_record"

module Home
  class Api::HomeController < Core::Api::BaseController
  	def user_access_info
  		user_role = current_user.role

		sql = "select lower(module_id::text || '.' || service_group_id::text || '.' || service_id::text) as srvc
			from e_schema.role_access 
			where (',' || access_groups::text || ',') LIKE '%,#{user_role},%' 
				and corporate_id = '#{context.corporate_id}'
				and establishment_id = '#{context.establishment_id}'"

		result = Core::EDBRecord.connection.execute(sql)

		data = []
		result.each do |row|
  			data << row['srvc']
		end

		pp data

  		render json: {data: data}
  	end
  end
end
