class AddExperienceToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :experience_id, :integer
  end
end
