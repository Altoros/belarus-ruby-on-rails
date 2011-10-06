class AddCommentsSubscriptionToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :comments_subscription, :boolean, :default => false
  end
end
