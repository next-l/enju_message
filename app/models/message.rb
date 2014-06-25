# -*- encoding: utf-8 -*-
class Message < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Statesman::Adapters::ActiveRecordModel
  scope :unread, -> {in_state('unread')}
  belongs_to :message_request
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  validates_presence_of :subject, :body #, :sender
  validates_presence_of :recipient, :on => :create
  validates_presence_of :receiver, :on => :update
  before_save :set_receiver
  after_create :send_notification

  acts_as_nested_set
  attr_accessor :recipient

  def state_machine
    ResourceImportFileStateMachine.new(self, transition_class: ResourceImportFileTransition)
  end

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
    to: :state_machine

  index_name "#{name.downcase.pluralize}-#{Rails.env}"

  after_commit on: :create do
    index_document
  end

  after_commit on: :update do
    update_document
  end

  after_commit on: :destroy do
    delete_document
  end

  settings do
    mappings dynamic: 'false', _routing: {required: false} do
      indexes :body
      indexes :subject
      indexes :receiver_id, type: 'integer'
      indexes :sender_id, type: 'integer'
      indexes :created_at, type: 'date'
      indexes :is_read, type: 'boolean'
    end
  end

  def as_indexed_json(options={})
    as_json.merge(
      is_read: read?
    )
  end

  paginates_per 10

  has_many :message_transitions

  def state_machine
    @state_machine ||= MessageStateMachine.new(self, transition_class: MessageTransition)
  end

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
    to: :state_machine

  def set_receiver
    if self.recipient
      self.receiver = User.friendly.find(self.recipient)
    end
  end

  def send_notification
    Notifier.message_notification(id).deliver if receiver.try(:email).present?
  end

  def read
  end

  def read?
    return true if current_state == 'read'
    false
  end

  private
  def self.transition_class
    MessageTransition
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
#  subject            :string(255)      not null
#  body               :text
#  message_request_id :integer
#  state              :string(255)
#  parent_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lft                :integer
#  rgt                :integer
#  depth              :integer
#

