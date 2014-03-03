class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_one :user_has_role
  has_one :role, :through => :user_has_role
  has_one :agent
  belongs_to :user_group
  belongs_to :required_role, :class_name => 'Role', :foreign_key => 'required_role_id'
  before_create :set_role_and_agent

  enju_message_user

  extend FriendlyId
  friendly_id :username

  def set_role_and_agent
    self.required_role = Role.where(:name => 'Librarian').first
    self.locale = I18n.default_locale.to_s
    unless self.agent
      self.agent = Agent.create(:full_name => self.username) if self.username
    end
  end

  def has_role?(role_in_question)
    return false unless role
    return true if role.name == role_in_question
    case role.name
    when 'Administrator'
      return true
    when 'Librarian'
      return true if role_in_question == 'User'
    else
      false
    end
  end

  def full_name
    username
  end
end
