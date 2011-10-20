class AddUserIdToArticles < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.references :user
    end
  end
end
