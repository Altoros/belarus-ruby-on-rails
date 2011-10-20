class AddRssLinkToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :rss_link, :string
  end

  def down
    remove_column :articles, :rss_link
  end
end
