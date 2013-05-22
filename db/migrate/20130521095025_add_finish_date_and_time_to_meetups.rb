class AddFinishDateAndTimeToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :finish_date_and_time, :datetime
  end
end
