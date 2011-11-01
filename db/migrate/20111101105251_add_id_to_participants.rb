class AddIdToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :id, :primary_key
  end
end
