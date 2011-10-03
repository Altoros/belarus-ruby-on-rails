class AddSubscribedFieldToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :subscribed, :boolean
  end
end
