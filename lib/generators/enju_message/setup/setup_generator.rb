class EnjuMessage::SetupGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :file, type: :string, default: "all"

  def copy_setup_files
    directory("db/fixtures", "db/fixtures/enju_message")
    return if file == 'fixture'
    inject_into_class "app/models/user.rb", User do
      "  include EnjuMessage::EnjuUser\n"
    end
  end
end
