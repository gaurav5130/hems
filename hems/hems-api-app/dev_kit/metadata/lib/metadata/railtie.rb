require 'metadata'
require 'rails'

module Metadata
	class Railtie < Rails::Railtie
		railtie_name :metadata

		rake_tasks do
			load "tasks/metadata_tasks.rake"
		end
	end
end