class Article < ActiveRecord::Base
  validates :title, :length => {:maximum => 255}
  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true
  has_many :comments, :order => "created_at DESC", :dependent => :delete_all

  belongs_to :user
  validates_associated :user
  attr_protected :user_id
  scope :published, where(:published => true)
end