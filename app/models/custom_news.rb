class CustomNews < ActiveRecord::Base
  validates :title, :length => {:maximum => 255, :message => "%{value} is not a valid size"}
  validates :title, :presence => {:message => "can't be blank"}
  validates :content, :presence => {:message => "can't be blank"}
end
