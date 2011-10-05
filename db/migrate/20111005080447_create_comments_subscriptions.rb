class CreateCommentsSubscriptions < ActiveRecord::Migration
  def change
    create_table :comments_subscriptions, :id => false do |t|
      t.references :profile
      t.references :article

      t.timestamps
    end
    add_index :comments_subscriptions, :profile_id
    add_index :comments_subscriptions, :article_id
  end
end
