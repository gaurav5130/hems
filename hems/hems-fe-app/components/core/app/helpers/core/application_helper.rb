module Core
  module ApplicationHelper
	def active(path)
		current_page?(path) ? 'active' : ''
	end  	
  end
end
