class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  validates_associated :profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes
  accepts_nested_attributes_for :profile, :allow_destroy => true

  def change_admin_state!
    toggle(:is_admin).save
  end
end
