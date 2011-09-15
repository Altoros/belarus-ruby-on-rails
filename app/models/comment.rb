class Comment < ActiveRecord::Base
  validates_presence_of :body
  validates_length_of :body, minimum: 5
  validates_associated :custom_news
  validates_associated :user
  belongs_to :custom_news
  belongs_to :user
end
