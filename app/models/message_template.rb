class MessageTemplate < ActiveRecord::Base
  default_scope {order("message_templates.position")}
  has_many :message_requests

  validates_uniqueness_of :status
  validates_presence_of :status, :title, :body

  acts_as_list

  paginates_per 10

  def embed_body(options = {})
    template = Erubis::Eruby.new(body)
    context = {
      library_group: LibraryGroup.site_config
    }.merge(options)
    template.evaluate(context)
  end

  def self.localized_template(status, locale)
    MessageTemplate.where(status: status, locale: locale).first || MessageTemplate.where(status: status).first
  end
end

# == Schema Information
#
# Table name: message_templates
#
#  id         :integer          not null, primary key
#  status     :string           not null
#  title      :text             not null
#  body       :text             not null
#  position   :integer
#  locale     :string           default("en")
#  created_at :datetime
#  updated_at :datetime
#
