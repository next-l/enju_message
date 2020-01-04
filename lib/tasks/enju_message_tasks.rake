require 'active_record/fixtures'
require 'tasks/message_template'

namespace :enju_message do
  desc "create initial records for enju_message"
  task setup: :environment do
    Dir.glob(Rails.root.to_s + '/db/fixtures/enju_message/*.yml').each do |file|
      ActiveRecord::FixtureSet.create_fixtures('db/fixtures/enju_message', File.basename(file, '.*'))
    end
  end

  desc "Send messages"
  task send: :environment do
    MessageRequest.send_messages if defined?(EnjuMessage)
  end
end
