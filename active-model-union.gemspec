require File.expand_path('../lib/active_model_union/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andres Bravo"]
  gem.email         = ["andresbravog@gmail.com"]
  gem.description   = %q{Active Model for using union between two defined models}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/andresbravog/active-model-union"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "active-model-union"
  gem.require_paths = ["lib"]
  gem.version       = ActiveModelUnion::VERSION

  gem.add_dependency 'activesupport'
  gem.add_dependency 'activemodel'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
