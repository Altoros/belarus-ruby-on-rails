class CommentRelationship < ActiveRecord::Base
  belongs_to :parent, :class_name => 'Comment', :foreign_key => :parent_comment_id
  belongs_to :child, :class_name => 'Comment', :foreign_key => :child_comment_id
end
