class CreateCommentRelationships < ActiveRecord::Migration
  def change
    create_table :comment_relationships do |t|
      t.integer :parent_comment_id
      t.integer :child_comment_id
    end
  end
end
