class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants, :id => false do |t|
      t.references :meetup
      t.references :user
      t.timestamps
    end

    add_index :participants, :user_id
    add_index :participants, :meetup_id
  end
end
