module Core
  class ApplicationRecord < ActiveRecord::Base
  	include Core::ModelHooks
  	
    self.abstract_class = true
    scope :apply_context, ->(context) { 
    		where("corporate_id = ? and establishment_id = ?", 
    			context.corporate_id, 
    			context.establishment_id) 
    }
  end
end
