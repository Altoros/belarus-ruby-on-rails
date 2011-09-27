class Comment < ActiveRecord::Base
  validates_presence_of :body
  validates_length_of :body, :minimum => 5
  belongs_to :custom_news
  belongs_to :user

  attr_protected :custom_news, :user
end
