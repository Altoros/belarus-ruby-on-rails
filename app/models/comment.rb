class Comment < ActiveRecord::Base
  validates_presence_of :body
  validates_length_of :body, :minimum => 5
  belongs_to :article
  belongs_to :user

  attr_protected :article_id, :user_id
end
