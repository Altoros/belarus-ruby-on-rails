class CommentsSubscription < ActiveRecord::Base
  belongs_to :profile
  belongs_to :article
  validates :article_id, :uniqueness => { :scope => :profile_id }
end
