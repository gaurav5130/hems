module Core
	class ContextVO
		include Virtus.model
		include ActiveModel::Validations

		attribute :corporate_id, String
		attribute :establishment_id, String

		def initialize(corporate_id, establishment_id)
			@corporate_id=corporate_id
			@establishment_id=establishment_id
		end
		
		validates :corporate_id, presence: true
		validates :establishment_id, presence: true
	end
end