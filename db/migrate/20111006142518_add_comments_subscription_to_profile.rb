class AddCommentsSubscriptionToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :subscribed_for_comments, :boolean, :default => false
  end
end
