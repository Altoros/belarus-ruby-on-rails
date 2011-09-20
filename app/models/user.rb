class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  delegate :first_name, :last_name, :to => :profile, :allow_nil => true
  validates_associated :profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
