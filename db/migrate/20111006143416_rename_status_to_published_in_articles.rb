class RenameStatusToPublishedInArticles < ActiveRecord::Migration
  def up
    rename_column :articles, :status, :published
    change_column :articles, :published, :boolean
  end

  def down
    change_column :articles, :published, :integer
    rename_column :articles, :published, :status
  end
end
