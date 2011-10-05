class AddDefaultValueForSubscribedInProfile < ActiveRecord::Migration
  def up
    change_column_default(:profiles, :subscribed, false)
  end

  def down
    change_column_default(:profiles, :subscribed, nil)
  end
end
