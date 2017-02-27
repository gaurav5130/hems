require_dependency "core/web_controller"
require_dependency "core/m_d_b_record"

module Setup
  class RoleAccessController < Core::WebController
	def index
		@roles = Auth::RoleGroup.apply_context(context)

		sql = "select mh.module_id, mh.title as mod_title, 
						msh.service_group_id, msh.title as srvc_grp_title,
						msd.service_id, msd.title as srvc_title
						from m_schema.module_header as mh, m_schema.module_service_header as msh, m_schema.module_service_detail as msd
						where mh.module_id = msh.module_id and
						mh.module_id = msd.module_id and
						msh.service_group_id = msd.service_group_id
						order by mh.module_id, msh.service_group_id, msd.service_id"

		result = Core::MDBRecord.connection.execute(sql)

		@groups = prepareGroups(result.to_hash)

		@groups
	end

	private

	# mod_id:
	# 	title:
	# 	srvc_grp_id:
	# 		title:
	# 		srvc_list : [{srvc_id: title}]

	def prepareGroups(result)
		result_h = Hash.new
		result.each {|key| 
			mod_id = key['module_id']
			mod_title = key['mod_title']
			srvc_grp_id = key['service_group_id']
			srvc_grp_title = key['srvc_grp_title']
			srvc_id = key['service_id']
			srvc_title = key['srvc_title']

			if result_h.has_key?(mod_id)
				mod_h = result_h[mod_id]
			else
				mod_h = Hash.new
				mod_h['title'] = mod_title
				mod_h['srvc_grp_list'] = Hash.new
			end

			if mod_h['srvc_grp_list'].has_key?(srvc_grp_id)
				srvc_grp_h = mod_h['srvc_grp_list'][srvc_grp_id]
			else
				srvc_grp_h = Hash.new
				srvc_grp_h['title'] = srvc_grp_title
				srvc_grp_h['srvc_list'] = Hash.new
			end

			if !"ROOT".eql?(srvc_id)
				srvc_grp_h['srvc_list'][srvc_id] = srvc_title
			end
			mod_h['srvc_grp_list'][srvc_grp_id] = srvc_grp_h
			result_h[mod_id] = mod_h		
		}

		result_h
	end
  end
end