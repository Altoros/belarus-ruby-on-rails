class Comment < ActiveRecord::Base
  before_destroy { |record| puts 'try'; record.children.map(& :destroy) }

  validates_presence_of :body
  validates_length_of :body, :minimum => 5
  belongs_to :article
  belongs_to :user
  has_many :child_comment_relationships,
           :class_name => 'CommentRelationship',
           :foreign_key => :parent_comment_id,
           :dependent => :destroy
  has_many :children, :through => :child_comment_relationships, :source => :child

  has_one :parent_comment_relationships,
           :class_name => 'CommentRelationship',
           :foreign_key => :child_comment_id,
           :dependent => :destroy
  has_one :parent, :through => :parent_comment_relationships



  scope :top_level, lambda {
    children_ids = CommentRelationship.select('DISTINCT child_comment_id').map(& :child_comment_id)
    where('id NOT IN (?)', children_ids) if children_ids.present?
  }

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
