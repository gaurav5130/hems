class AccessContext
	include Virtus.model
	include ActiveModel::Validations

	attribute :user, 		Auth::Users
	attribute :action, 		String
	attribute :access_key, 	String
	attribute :context,		Core::ContextVO

	#TODO - Validate with specific error messages.	
	validates_presence_of :access_key, :message => "_access not set for the route."
	validates :user, :action, :context, presence: true

	def initialize(data)
		@user = data[:user]
		@action = data[:action]
		@access_key = data[:access_key]
		@context = data[:context]
	end
end