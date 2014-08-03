class EnjuMessage::SetupGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :file, :type => :string, :default => "all"

  def copy_setup_files
    directory("db/fixtures", "db/fixtures/enju_message")
    return if file == 'fixture'
    rake("enju_message_engine:install:migrations")
    inject_into_file 'app/models/user.rb',
      "  enju_message_user_model\n", :after => "enju_leaf_user_model\n"
  end
end
