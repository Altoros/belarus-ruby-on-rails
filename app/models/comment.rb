class Comment < ActiveRecord::Base
  validates_presence_of :body
  validates_length_of :body, :minimum => 5
  belongs_to :article
  belongs_to :user

  attr_protected :article_id, :user_id

  def deliver
    commentators_without.each do |user|
      Notifier.comment(user.email, article).deliver
    end
  end

  def commentators_without
    Comment.select('DISTINCT users.email').joins(:user => :profile).merge(Profile.subscribed_for_comments)
              .where(:article_id => article_id).where('comments.user_id <> ?', user_id)
  end
end
