class User < ActiveRecord::Base
  has_many :user_tokens, :dependent => :delete_all
  has_one :profile, :dependent => :destroy
  validates_associated :profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes
  accepts_nested_attributes_for :profile, :allow_destroy => true

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

  def self.create_based_omniauth(omniauth)
    if omniauth['user_info']['email'].present?
      user = User.find_or_initialize_by_email(:email => omniauth['user_info']['email'])
    else
      user = User.new
    end

    user.apply_omniauth(omniauth)
    user.confirm! unless user.email.blank?

    user
  end

  def change_admin_state!
    toggle!(:is_admin)
  end

end
