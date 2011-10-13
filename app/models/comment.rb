class Comment < ActiveRecord::Base
  validates_presence_of :body
  validates_length_of :body, :minimum => 5
  belongs_to :article
  belongs_to :user

  attr_protected :article_id, :user_id

  def self.deliver(comment_id, exclude_user_id = nil)
    article = find(comment_id).article
    commentators_for_article(article.id, exclude_user_id).each do |email|
      Notifier.comment(email, article).deliver
    end
  end

  def self.commentators_for_article(article_id, exclude_user_id = nil)
    condition = exclude_user_id ? ["comments.article_id = ?  AND comments.user_id <> ? AND profiles.subscribed_for_comments = 1", article_id, exclude_user_id] :
        ["comments.article_id = ?  AND profiles.subscribed_for_comments = 1", article_id]

    self.all(:select => "users.email",
        :joins => "INNER JOIN users ON comments.user_id = users.id INNER JOIN profiles ON profiles.user_id = users.id",
        :conditions => condition)
      .collect(& :email)
  end
end
