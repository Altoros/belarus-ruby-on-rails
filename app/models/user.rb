class User < ActiveRecord::Base
  has_many :user_tokens, :dependent => :delete_all
  has_many :comments
  has_many :participants
  has_one :profile, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes
  accepts_nested_attributes_for :profile

  validates_associated :profile
  validates :profile, :presence => true

  scope :not_admin, where('is_admin = ?', false)

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        user.user_tokens.build(:provider => data['provider'], :uid => data['uid'])
      end
    end
  end

  def password_required?
    (user_tokens.empty? || password.present?) && super
  end

  def bind_social_network(provider, uid)
    self.user_tokens.find_or_create_by_provider_and_uid(provider, uid)
  end

  def self.find_by_social_network(provider, uid)
    joins(:user_tokens).where(:user_tokens => {:provider => provider, :uid => uid}).first
  end

  def apply_omniauth(omniauth)
    if omniauth
      build_profile unless profile
      profile.first_name = omniauth['user_info']['first_name'] if profile.first_name.blank?
      profile.last_name = omniauth['user_info']['last_name'] if profile.last_name.blank?

      if omniauth.include?('provider') && omniauth.include?('uid')
        user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      end
    end
  end

  def self.build_via_social_network(attributes)
    if attributes['user_info']['email']
      user = User.find_or_initialize_by_email(:email => attributes['user_info']['email'])
    else
      user = User.new
    end

    user_attributes = attributes['user']
    if user_attributes
      user.email = user_attributes['email'] if user_attributes['email']

      user.build_profile unless user.profile
      user.profile_attributes = user_attributes['profile_attributes']
    end

    user.apply_omniauth(attributes)

    user
  end

  def change_admin_state!
    toggle!(:is_admin)
  end
end
