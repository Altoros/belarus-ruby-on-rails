class User < ActiveRecord::Base
  has_many :user_tokens
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

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
      self.first_name = omniauth['user_info']['first_name'] if first_name.blank?
      self.last_name = omniauth['user_info']['last_name'] if last_name.blank?
    end

    if omniauth && omniauth.include?('provider') && omniauth.include?('uid')
      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    end
  end

  def self.create_based_omniauth(omniauth)
    if omniauth['user_info']['email'].present?
      user = User.new
    else
      user = User.find_or_initialize_by_email(:email => omniauth['user_info']['email'])
    end

    user.apply_omniauth(omniauth)
    user.confirm! unless user.email.blank?

    user
  end
end
