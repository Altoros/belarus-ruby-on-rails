class AddUserIdToArticles < ActiveRecord::Migration
  def up
    change_table :articles do |t|
      t.references :user
    end
  end

  def down
    remove_column :articles, :user_id
  end
end