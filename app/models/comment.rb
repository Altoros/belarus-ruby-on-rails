class Comment < ActiveRecord::Base
  validates_presence_of :body
  validates_length_of :body, :minimum => 5
  belongs_to :article
  belongs_to :user

  attr_protected :article_id, :user_id

  def deliver(excluded_users = nil)
    commentators_without(excluded_users).each do |user|
      Notifier.comment(user.email, article).deliver
    end
  end

  def commentators_without(exclude_user_id = nil)
    condition = if exclude_user_id
      ["comments.article_id = ? AND comments.user_id <> ? AND
      profiles.subscribed_for_comments = 1", article_id, exclude_user_id]
    else
      [:comments => { :article_id => article_id}, :profiles => { :subscribed_for_comments => true }]
    end

  Comment.all(:select => "users.email",
    :joins => {:user => :profile},
    :conditions => condition)
  end
end
