$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "internal_styles/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "internal_styles"
  spec.version     = InternalStyles::VERSION
  spec.authors     = ["Matthew Eagar"]
  spec.email       = ["meagar@gmail.com"]
  spec.homepage    = ""
  spec.summary     = "Internal Styles."
  spec.description = "Internal Styles"
  spec.license     = ""

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'rails', '~> 5.2'
  spec.add_dependency 'bootstrap', '~> 4.1'
  spec.add_dependency 'font-awesome-rails', '~>4.7'
  spec.add_dependency 'slim', '~>4.0'
  spec.add_dependency 'sass-rails', '~> 5.0'

  spec.add_development_dependency "sqlite3"
end
