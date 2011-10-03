class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do
      string :level
    end
  end
end
