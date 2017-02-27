require 'seedkit'
require 'rails'
module Seedkit
	class Railtie < Rails::Railtie
		railtie_name :seedkit

		rake_tasks do
			load "tasks/seedkit_tasks.rake"
		end
	end
end