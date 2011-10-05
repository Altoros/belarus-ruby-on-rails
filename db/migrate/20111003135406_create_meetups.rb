class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :title
      t.text :description
      t.string :address
      t.datetime :date_and_time

      t.timestamps
    end
  end
end
