class RemoveAuthorFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :author
  end

  def down
    add_column :comments, :author, :string
  end
end
