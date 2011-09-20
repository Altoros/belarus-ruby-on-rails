class Profile < ActiveRecord::Base
  validates :first_name, :presence => {:message => "can't be blank"}
  validates :first_name, :length => {:maximum => 255, :message => "%{value} is not a valid size"}
  validates :last_name, :presence => {:message => "can't be blank"}
  validates :last_name, :length => {:maximum => 255, :message => "%{value} is not a valid size"}
  belongs_to :user
end
