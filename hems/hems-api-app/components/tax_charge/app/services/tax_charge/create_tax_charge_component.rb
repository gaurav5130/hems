module TaxCharge
	class CreateTaxChargeComponent< Core::BaseService
		include Virtus.model
		include ActiveModel::Validations
		attribute :component_id, String
		attribute :short_name, String
		attribute :long_name, String
		attribute :charge_or_tax, String
		attribute :calculation_type, String
		attribute :applied_on_rate, String
		attribute :round_off_to, String
		attribute :round_off_to_num, String
		attribute :applicable_amount, Float
		attribute :minimum_tax_amount, Float
		attribute :maximum_tax_amount, Float
		attribute :gl_detail, String
		attribute :country, String
		attribute :state, String
		attribute :slab, SlVO

		validates :charge_or_tax, presence: true
		validates :component_id, presence: true
		validates :calculation_type, presence: true
		validates :applied_on_rate, presence: true

		
		
		#Initialization of this service
		def initialize(params)
		  	@component_id=params[:component_id]
	      	@short_name=params[:short_name]
			@long_name=params[:long_name]
			@charge_or_tax=params[:charge_or_tax]
			@calculation_type=params[:calculation_type]
			@applied_on_rate=params[:applied_on_rate]
			@round_off_to=params[:round_off_to]
			@round_off_to_num=params[:round_off_to_num]
			@applicable_amount=params[:applicable_amount]
			@minimum_tax_amount=params[:minimum_tax_amount]
			@maximum_tax_amount=params[:maximum_tax_amount]
			@gl_detail=params[:gl_detail]
			@country=params[:country]
			@state=params[:state]
			@slab=[]
			@count=0
			c=0
			serial_no="serial_no_"
			slab_start_amount="slab_start_amount_"
			slab_end_amount="slab_end_amount_"
			slab_calculation_type="slab_calculation_type_"
			slab_applicable_amount="slab_applicable_amount_"
			
			
			serial_no=serial_no+c.to_s
			slab_start_amount=slab_start_amount+c.to_s
			slab_end_amount=slab_end_amount+c.to_s
			slab_calculation_type=slab_calculation_type+c.to_s
			slab_applicable_amount=slab_applicable_amount+c.to_s

			
			while (params[serial_no] && params[serial_no]!="") do
				@slab[c]=SlVO.new
				@slab[c].serial_no=params[serial_no]
				@slab[c].slab_start_amount=params[slab_start_amount]
				@slab[c].slab_end_amount=params[slab_end_amount]
				@slab[c].slab_calculation_type=params[slab_calculation_type]
				@slab[c].slab_applicable_amount=params[slab_applicable_amount]
				p @slab[c].serial_no
				c=c+1
				p @slab[0].serial_no
				p "success"
				serial_no="serial_no_"
				slab_start_amount="slab_start_amount_"
				slab_end_amount="slab_end_amount_"
				slab_calculation_type="slab_calculation_type_"
				slab_applicable_amount="slab_applicable_amount_"
				
				serial_no=serial_no+c.to_s
				slab_start_amount=slab_start_amount+c.to_s
				slab_end_amount=slab_end_amount+c.to_s
				slab_calculation_type=slab_calculation_type+c.to_s
				slab_applicable_amount=slab_applicable_amount+c.to_s
				@count=c
			end
		end
		
		
		
		def validate
			if !(valid?)
				return Core::ServiceError.new("Validation failed.")
			end

			return Core::ServiceSuccess.new
		end

		def process
			p @count
			for j in 0..@count
				p "in process"
				p j
				charge_tax_component_master=TaxChargeComponentMaster.new
				charge_tax_component_master.corporate_id=@context.corporate_id
				charge_tax_component_master.establishment_id=@context.establishment_id
				charge_tax_component_master.charge_or_tax=@charge_or_tax
				charge_tax_component_master.component_id=@component_id
				charge_tax_component_master.calculation_type=@calculation_type
				charge_tax_component_master.short_name=@short_name
				charge_tax_component_master.long_name=@long_name
				charge_tax_component_master.applied_on_rate=@applied_on_rate
				charge_tax_component_master.round_off_to=@round_off_to
				charge_tax_component_master.round_off_to_num=@round_off_to_num
				charge_tax_component_master.applicable_amount=@applicable_amount
				charge_tax_component_master.minimum_tax_amount=@minimum_tax_amount
				charge_tax_component_master.maximum_tax_amount=@maximum_tax_amount
				charge_tax_component_master.gl_detail=@gl_detail
				charge_tax_component_master.country=@country
				charge_tax_component_master.state=@state
				charge_tax_component_master.created_by=""
				charge_tax_component_master.updated_by=""
				charge_tax_component_master.created_at=DateTime.now
				charge_tax_component_master.updated_at=DateTime.now
				if(@count>0 && j<@count)
					charge_tax_component_master.serial_no=@slab[j].serial_no
					charge_tax_component_master.slab_start_amount=@slab[j].slab_start_amount
					charge_tax_component_master.slab_end_amount=@slab[j].slab_end_amount
					charge_tax_component_master.slab_calculation_type=@slab[j].slab_calculation_type
					charge_tax_component_master.slab_applicable_amount=@slab[j].slab_applicable_amount
					
				end
				if(@count==0)

					charge_tax_component_master.serial_no=1
					charge_tax_component_master.slab_start_amount=0
					charge_tax_component_master.slab_end_amount=0
					charge_tax_component_master.slab_calculation_type=""
					charge_tax_component_master.slab_applicable_amount=0
					
				end
				charge_tax_component_master.save!
				if(j==@count-1)
						break
				end
			end
			success_obj = Core::ServiceSuccess.new
			success_obj.status(200)
			success_obj.data({"msg": "Code Inserted"})
			success_obj
		end
	end
end