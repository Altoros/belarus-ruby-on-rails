class Article < ActiveRecord::Base
  validates :title, :length => {:maximum => 255, :message => "%{value} is not a valid size"}
  validates :title, :presence => {:message => "can't be blank"}
  validates :content, :presence => {:message => "can't be blank"}
  has_many :comments, :order => "created_at DESC", :dependent => :delete_all
end
