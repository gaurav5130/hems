module Order
	class SaveOrderDetail < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		attribute :params, String
		validates :params, presence: true

		private
		
		#Static and business validations of this service
		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new		
		end
	
		private
		#Process logic of this service
		def process
			preorder= OrderHeader.where(member_id: params["member_id"]).first
			p "printing ot_number"
			ot_number=rand.to_s[2..10].to_i
			for i in 0..7
				if((params[:item_name][i.to_s]!=nil) && (params[:quantity][i.to_s]!=nil) )
					od=OrderDetail.new()
					od.corporate_id=@context.corporate_id
					od.establishment_id=@context.establishment_id
					od.order_number=preorder.order_number
					od.ot_number=ot_number
					od.order_date=Time.now
					od.order_time=Time.now.strftime("%I:%M:%S")
					od.serial_number=i
					od.ot_datetime=Time.now
					#od.item_code=(params[:itemname][].split('-').first)
					od.item_code=params[:item_name][i.to_s]
					od.quantity=params[:quantity][i.to_s]
					od.save!
					next
				end
			end

			success_obj = Core::ServiceSuccess.new
			SaveOrderTicketStatusTracking.call(@context,params:params,ot_number:ot_number)
			success_obj.status(200)
			success_obj.data({"msg": "Code Inserted"})
			success_obj
		end
	end
end
