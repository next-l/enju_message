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
  s.test_files = Dir["spec/**/*"] - Dir["spec/dummy/log/*"] - Dir["spec/dummy/solr/{data,pids}/*"]

  s.add_dependency "enju_seed", "~> 0.2.0.pre6"
  s.add_dependency "simple_form", "~> 3.0"
  s.add_dependency "awesome_nested_set", "~> 3.0.0.rc5"
  s.add_dependency "statesman"
  s.add_dependency "resque_mailer"
  s.add_dependency "rails_autolink"

  s.add_development_dependency "sqlite3"
  #s.add_development_dependency "enju_leaf", "~> 1.2.0.pre1"
  s.add_development_dependency "rspec-rails", "2.99"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "elasticsearch-extensions"
end
