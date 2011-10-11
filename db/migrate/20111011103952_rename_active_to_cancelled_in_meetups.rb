class RenameActiveToCancelledInMeetups < ActiveRecord::Migration
  def up
    rename_column :meetups, :active, :cancelled
    change_column_default :meetups, :cancelled, false
  end

  def down
    change_column_default :meetups, :cancelled, true
    rename_column :meetups, :cancelled, :active
  end
end
