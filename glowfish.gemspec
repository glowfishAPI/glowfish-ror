$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "glowfish/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "glowfish"
  s.version     = Glowfish::VERSION
  s.authors     = ["Patrick"]
  s.email       = ["patrick@glowfi.sh"]
  s.homepage    = "https://glowfi.sh/"
  s.summary     = "Now with machine guns and rocket launchers."
  s.description = "Mobile machine learning as a service."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"
  s.add_dependency "json"

  s.add_development_dependency "sqlite3"
end
