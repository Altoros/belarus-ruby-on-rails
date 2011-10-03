class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :level
    end
  end
end
