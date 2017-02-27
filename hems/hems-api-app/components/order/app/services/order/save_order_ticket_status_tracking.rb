module Order
	class SaveOrderTicketStatusTracking < Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		attribute :params, String
		attribute :ot_number, Integer
		
		validates :ot_number, presence: true
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
			for i in 0..7
				if((params[:item_name][i.to_s]!=nil) && (params[:quantity][i.to_s]!=nil) )
					ot=OrderTicketStatusTracking.new()
					ot.corporate_id=@context.corporate_id
					ot.establishment_id=@context.establishment_id
					ot.ot_number=ot_number
					ot.ot_datetime=Time.now
					ot.item_code=params[:item_name][i.to_s]
					ot.quantity=params[:quantity][i.to_s]
					#od.item_code=(params[:itemname][].split('-').first)
					ot.ot_status="order started"
					ot.ot_updated_time=Time.now.strftime("%I:%M:%S")
					ot.save!
					next
				end
			end
			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data({"msg": "Code Inserted"})
			success_obj
		end
	end
end