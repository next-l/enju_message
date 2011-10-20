require 'active_record/fixtures'
desc "copy fixtures for enju_message"
task :enju_message => :environment do
  ActiveRecord::Fixtures.create_fixtures(File.expand_path(File.dirname(__FILE__)) + '/../../db/fixtures/', File.basename('message_templates', '.yml'))
end
