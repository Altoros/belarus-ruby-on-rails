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

  def apply_omniauth(omniauth)
    self.first_name = omniauth['user_info']['first_name'] if first_name.blank?
    self.last_name = omniauth['user_info']['last_name'] if last_name.blank?

    user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (user_tokens.empty? || !password.blank?) && super
  end

  def self.create_based_omniauth(omniauth)
    unless omniauth.recursive_find_by_key("email").blank?
      user = User.find_or_initialize_by_email(:email => omniauth.recursive_find_by_key("email"))
    else
      user = User.new
    end

    user.apply_omniauth(omniauth)
    user.confirm! unless user.email.blank?

    user
  end
end
