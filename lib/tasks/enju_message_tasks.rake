require 'active_record/fixtures'
desc "create initial records for enju_message"
namespace :enju_message do
  task :setup => :environment do
    Dir.glob(Rails.root.to_s + '/db/fixtures/enju_message/*.yml').each do |file|
      ActiveRecord::Fixtures.create_fixtures('db/fixtures/enju_message', File.basename(file, '.*'))
    end
  end
end
