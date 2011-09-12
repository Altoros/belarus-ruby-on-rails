class CreateCustomNews < ActiveRecord::Migration
  def change
    create_table :custom_news do |t|
      t.primary_key :id
      t.string :title
      t.text :content
      t.integer :status

      t.timestamps
    end
  end
end
