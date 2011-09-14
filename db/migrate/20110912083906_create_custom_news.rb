class CreateCustomNews < ActiveRecord::Migration
  def up
    create_table :custom_news do |t|
      t.string :title
      t.text :content
      t.integer :status

      t.timestamps
    end
  end

  def down
    drop_table :custom_news
  end
end
