class Comment < ActiveRecord::Base
  validates_presence_of :body, :custom_news_id, :user_id
  validates_length_of :body, :minimum => 5
  validates_associated :custom_news
  belongs_to :custom_news
  belongs_to :user
  attr_protected :custom_news
end
