require 'erubis'
class MessageRequest < ActiveRecord::Base
  attr_accessible :body
  attr_accessible :sender, :receiver, :message_template, :sent_at, :as => :admin
  scope :not_sent, where('sent_at IS NULL AND state = ?', 'pending')
  scope :sent, where(:state => 'sent')
  scope :started, where(:state => 'started')
  belongs_to :message_template, :validate => true
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id", :validate => true
  belongs_to :receiver, :class_name => "User", :foreign_key => "receiver_id", :validate => true
  has_many :messages

  validates_associated :sender, :receiver, :message_template
  validates_presence_of :sender, :receiver, :message_template, :body

  state_machine :initial => :pending do
    before_transition any - :sent => :sent, :do => :send_message

    event :sm_send_message do
      transition any - :sent => :sent
    end

    event :sm_start do
      transition :pending => :started
    end
  end

  def self.per_page
    10
  end

  def start_sending_message
    sm_start!
    sm_send_message!
  end

  def send_message
    message = nil
    MessageRequest.transaction do
      if self.body
        message = Message.create!(:sender => self.sender, :recipient => self.receiver.username, :subject => self.subject, :body => self.body)
      else
        raise 'body is empty!'
      end
      self.update_attributes({:sent_at => Time.zone.now})
      if ['reservation_expired_for_patron', 'reservation_expired_for_patron'].include?(self.message_template.status)
        self.receiver.reserves.each do |reserve|
          reserve.update_attribute(:expiration_notice_to_patron, true)
        end
      end
    end
    return message
  end

  def subject
    self.message_template.title
  end

  def save_message_body(options = {})
    options = {
      :receiver => self.receiver,
      :locale => self.receiver.locale
    }.merge(options)
    self.update_attributes!({:body => self.message_template.embed_body(options)})
  end

  def self.send_messages
    count = MessageRequest.not_sent.size
    MessageRequest.not_sent.each do |request|
      request.start_sending_message
    end
    logger.info "#{Time.zone.now} sent #{count} messages!"
  end
end

# == Schema Information
#
# Table name: message_requests
#
#  id                  :integer         not null, primary key
#  sender_id           :integer
#  receiver_id         :integer
#  message_template_id :integer
#  sent_at             :datetime
#  deleted_at          :datetime
#  body                :text
#  state               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

