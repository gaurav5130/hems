module Order
	class SaveOrder	< Core::BaseService
		include Virtus.model
		include ActiveModel::Validations

		attribute :facility_code, String
		attribute :member_id, String
		attribute :table_number, String
		attribute :waitor, String
		attribute :steward, String
		attribute :params, String
		
		validates :facility_code, presence: true
		validates :member_id, presence: true
		validates :params, presence: true
		validates :table_number, presence: true
		

		#Initialization of this service
		def initialize(params)
			@params=params
			@facility_code = params[:facility_code]
	      	@member_id=params[:member_id]
			@table_number=params[:table_number]
			@steward=params[:steward]
			@waitor=params[:waitor]
		end
		
		

		private
		
		#Static and business validations of this service
		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new		
		end
		
		
		#Process logic of this service
		def process
			OrderTicketStatusTracking.transaction do
				preorder= OrderHeader.where(member_id: @member_id).first
				if(preorder==nil)
					order_header=OrderHeader.new
					order_header.corporate_id=@context.corporate_id
					order_header.establishment_id=@context.establishment_id
					order_header.order_date=Time.now
					order_header.order_time=Time.now.strftime("%I:%M:%S")
					order_header.table_number=@table_number

					order_header.member_id=@member_id
					order_header.steward=@steward
					order_header.waitor=@waitor
					order_header.facility_code=@facility_code
					order_header.order_status='O'
					order_header.save!
					preorder=order_header
				end
				SaveOrderDetail.call(@context,params:@params)
				success_obj = Core::ServiceSuccess.new
				success_obj.status(200)
				success_obj.data({"msg": "Order Inserted"})
				success_obj
			end
		end
	end
end
