$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem"s version:
require "enju_message/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_message"
  s.version     = EnjuMessage::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["nabeta@fastmail.fm"]
  s.homepage    = "https://github.com/next-l/enju_message"
  s.summary     = "enju_message plugin"
  s.description = "Message management for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"] - Dir["spec/dummy/log/*"] - Dir["spec/dummy/solr/{data,pids,default,development,test}/*"] - Dir["spec/dummy/tmp/*"]

  s.add_dependency "simple_form"
  s.add_dependency "awesome_nested_set"
  s.add_dependency "statesman"
  s.add_dependency "resque_mailer"
  s.add_dependency "rails_autolink"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mysql2"
  s.add_development_dependency "pg"
  s.add_development_dependency "enju_leaf", "~> 1.1.0.rc17"
  s.add_development_dependency "rspec-rails", "~> 3.2"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "sunspot_solr", "~> 2.2"
  s.add_development_dependency "sunspot-rails-tester"
  s.add_development_dependency "annotate"
  s.add_development_dependency "rspec-activemodel-mocks"
  s.add_development_dependency "appraisal"
end
