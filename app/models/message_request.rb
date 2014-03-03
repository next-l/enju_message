require 'erubis'
class MessageRequest < ActiveRecord::Base
  attr_accessible :body
  attr_accessible :sender, :receiver, :message_template, :body, :as => :admin
  scope :not_sent, where('sent_at IS NULL AND state = ?', 'pending')
  scope :sent, where(:state => 'sent')
  scope :started, where(:state => 'started')
  belongs_to :message_template, :validate => true
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id", :validate => true
  belongs_to :receiver, :class_name => "User", :foreign_key => "receiver_id", :validate => true
  has_many :messages

  validates_associated :sender, :receiver, :message_template
  validates_presence_of :sender, :receiver, :message_template
  validates_presence_of :body, :on => :update

  state_machine :initial => :pending do
    before_transition any - :sent => :sent, :do => :send_message

    event :sm_send_message do
      transition any - :sent => :sent
    end

    event :sm_start do
      transition :pending => :started
    end
  end

  paginates_per 10

  def start_sending_message
    sm_start!
    sm_send_message!
  end

  def self.send_notice_message(status, recieve_usernames, options = {})
    receivers = recieve_usernames.gsub(' ','').split(',').map{|username| User.where(:username => username).first}
    receivers.each do |receiver|
      receiver.send_message(status, options)
    end
  end

  def self.send_notice_to_librarians(status, options = {})
    system_user = User.find(1)
    receivers = SystemConfiguration.get('notice_receiver').gsub(' ','').split(',').map{|username| User.where(:username => username).first}
    receivers.compact.each do |receiver|
      receiver.send_message(status, options)
    end
  end

  def send_message
    message = nil
    MessageRequest.transaction do
      if body
        message = Message.new
        message.sender = sender
        message.recipient  = receiver.username
        message.subject = subject
        message.body = body
        message.save!
      else
        raise 'body is empty!'
      end
      self.sent_at = Time.zone.now
      save(:validate => false)
      if ['reservation_expired_for_agent', 'reservation_expired_for_agent'].include?(self.message_template.status)
        self.receiver.reserves.each do |reserve|
          reserve.expiration_notice_to_agent = true
          reserve.save(:validate => false)
        end
      end
    end
    return message
  end

  def subject
    message_template.title
  end

  def save_message_body(options = {})
    options = {
      :receiver => self.receiver,
      :locale => self.receiver.locale
    }.merge(options)
    self.update_attributes!({:body => self.message_template.embed_body(options)})
  end

  def self.send_messages
    begin
      return if Rails.cache.read('sending_message')
      Rails.cache.write('sending_message', true)
      count = MessageRequest.not_sent.size
      MessageRequest.not_sent.each do |request|
         request.start_sending_message
      end
      logger.info "#{Time.zone.now} sent #{count} messages!"
    ensure
      Rails.cache.write('sending_message', false)
    end
  end
end

# == Schema Information
#
# Table name: message_requests
#
#  id                  :integer          not null, primary key
#  sender_id           :integer
#  receiver_id         :integer
#  message_template_id :integer
#  sent_at             :datetime
#  deleted_at          :datetime
#  body                :text
#  state               :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

