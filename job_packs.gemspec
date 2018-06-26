$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "job_packs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "job_packs"
  s.version     = JobPacks::VERSION
  s.authors     = ["Eduardo Lagares"]
  s.email       = ["eduardo.lagares@al.go.leg.br"]
  s.homepage    = "https://github.com/eduardolagares/job_packs"
  s.summary     = "Job Packs and Monitor"
  s.description = "Run jobs in a pack and monitor them."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.1"
end
