class AddStatusToMeetup < ActiveRecord::Migration
  def change
    add_column :meetups, :status, :boolean, :default => true
  end
end
