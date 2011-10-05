class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :topic
      t.text :description
      t.string :place
      t.datetime :date_and_time
      t.boolean :is_active, :default => true
    end
  end
end
