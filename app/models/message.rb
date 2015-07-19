# -*- encoding: utf-8 -*-
class Message < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordQueries
  scope :unread, -> {in_state('unread')}
  belongs_to :message_request
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  validates_presence_of :subject, :body #, :sender
  validates_presence_of :recipient, on: :create
  validates_presence_of :receiver, on: :update
  validate :valid_recipient?
  before_save :set_receiver
  after_save :index
  after_destroy :remove_from_index
  after_create :send_notification

  acts_as_nested_set
  attr_accessor :recipient

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
    to: :state_machine

  searchable do
    text :body, :subject
    string :subject
    integer :receiver_id
    integer :sender_id
    time :created_at
    boolean :is_read do
      read?
    end
  end

  paginates_per 10
  has_many :message_transitions
  after_create :set_default_state

  def state_machine
    @state_machine ||= MessageStateMachine.new(self, transition_class: MessageTransition)
  end

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
    to: :state_machine

  def set_receiver
    if recipient
      self.receiver = User.find(recipient)
    end
  end

  def send_notification
    Notifier.message_notification(id).deliver if receiver.try(:email).present?
  end

  def read
    transition_to!(:read)
  end

  def read?
    return true if current_state == 'read'
    false
  end

  def valid_recipient?
    if recipient
      if User.where(username: recipient).empty?
        errors.add(:recipient)
      end
    end
  end

  private
  def self.transition_class
    MessageTransition
  end

  def self.initial_state
    :pending
  end

  def set_default_state
    transition_to!(:unread)
  end
end

# == Schema Information
#
# Table name: messages
#
#  id                 :integer          not null, primary key
#  read_at            :datetime
#  receiver_id        :integer
#  sender_id          :integer
#  subject            :string           not null
#  body               :text
#  message_request_id :integer
#  parent_id          :integer
#  created_at         :datetime
#  updated_at         :datetime
#  lft                :integer
#  rgt                :integer
#  depth              :integer
#
