require Rails.root.join('lib', 'devise', 'encryptors', 'md5')

class User < ActiveRecord::Base
  has_many :user_tokens, :dependent => :delete_all
  has_many :articles
  has_many :comments
  has_many :participants, :dependent => :delete_all
  has_one :profile, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :encryptable

  attr_accessible :id, :email, :password, :password_confirmation, :remember_me, :profile_attributes, :created_at
  accepts_nested_attributes_for :profile

  attr_accessor :registration_recaptcha_passed

  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false
  validates_associated :profile
  validates :profile, :presence => true
  validates :registration_recaptcha_passed, presence: true, on: :create, if: ->() { Recaptcha.configured? }

  scope :admin, where('is_admin = ?', true)
  scope :not_admin, where('is_admin = ?', false)
  scope :banned, where('banned = ?', true)
  scope :filter, lambda{ |*filters|
    includes(:profile => :experience).joins(:profile).merge(Profile.filter(filters))
  }

  searchable(:include => [:profile, :participants]) do
    text :email
    text :first_name do
      self.profile.first_name
    end
    text :last_name do
      self.profile.last_name
    end
    string :meetup_id, :multiple => true do
      self.participants.collect(&:meetup_id)
    end
    time :created_at, :trie => true
    time :created_participant_at, :multiple => true, :trie => true do
      self.participants.collect(&:created_at)
    end
    time :created_last_participant_at do
      self.participants.last.try(:created_at)
    end
    string :accepted, :multiple => true do
      self.participants.map{|x| "#{x.meetup_id}_#{x.accepted}"}
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        user.user_tokens.build(:provider => data['provider'], :uid => data['uid'])
      end
    end
  end

  def password_required?
    (user_tokens.empty? || password.present? || reset_password_token.present? ) && super
  end

  def valid_password?(password)
    return false if encrypted_password.blank?
    Devise.secure_compare(Devise::Encryptors::Md5.digest(password, nil, self.password_salt, nil), self.encrypted_password)
  end

  def bind_social_network(provider, uid)
    self.user_tokens.find_or_create_by_provider_and_uid(provider, uid)
  end

  def self.find_by_social_network(provider, uid)
    token = UserToken.where(:provider => provider, :uid => uid).first
    token.user if token
  end

  def apply_omniauth(omniauth)
    if omniauth
      build_profile unless profile
      profile.first_name = omniauth.info.first_name if profile.first_name.blank?
      profile.last_name = omniauth.info.last_name if profile.last_name.blank?
      if omniauth.info.image.present? && !profile.avatar.exists?
        profile.avatar = fetch_avatar omniauth.info.image
      end

      if omniauth.provider && omniauth.uid
        user_tokens.build(:provider => omniauth.provider, :uid => omniauth.uid)
      end
    end
  end

  def self.build_via_social_network(omniauth, user_attributes = nil)
    if omniauth.info.email
      user = User.find_or_initialize_by_email(:email => omniauth.info.email)
    else
      user = User.new
    end

    if user_attributes
      user.email = user_attributes['email'] if user_attributes['email']

      user.build_profile unless user.profile
      user.profile_attributes = user_attributes['profile_attributes']
    end

    user.apply_omniauth(omniauth)

    user
  end

  def change_admin_state!
    toggle!(:is_admin)
  end

  def change_banned_state!
    toggle!(:banned)
  end

  def update_with_password(params={})

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    update_attributes(params)
  end

  def fetch_avatar(path)
    require "open-uri"
    io = open(URI.parse(path.sub("square","large")))
    def io.original_filename; Digest::MD5.hexdigest(rand.to_s) + '.jpg'; end;
    io
  end

  def answered_questions(filter)
    answered_questions = []
    participants.participants_on(filter).each do |participant|
      participant.quizzes.each do |quiz|
        answer = quiz.answer
        if answer.class == Array
          answer -= [""]
          answer = answer.join(", ")
        end
        answered_questions << "#{quiz.question.gist}: #{answer};"
      end
    end
    answered_questions
  end

  def unsubscribe_token
    Digest::MD5.hexdigest("#{self.email} #{self.created_at.utc}")
  end
end
