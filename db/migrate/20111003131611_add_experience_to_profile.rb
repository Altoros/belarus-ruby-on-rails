class AddExperienceToProfile < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.references :experience
    end
  end
end
