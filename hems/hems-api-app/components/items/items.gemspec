$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "items/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "items"
  s.version     = Items::VERSION
  s.authors     = ["ANIL-PALAKODETI\anilpalakodeti"]
  s.email       = ["anilkumar@pratishthanventures.com"]
  s.homepage    = "http://hems.com"
  s.summary     = "Summary of Items."
  s.description = "Description of Items."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"

  s.add_development_dependency "activerecord-jdbcpostgresql-adapter"
end
