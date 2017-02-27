require_dependency "core/e_d_b_record"

module Order
	class OrderTicketStatusTracking < Core::EDBRecord
		def upcase_attrs
	  		["corporate_id","establishment_id"]
	  	end
	end
end
