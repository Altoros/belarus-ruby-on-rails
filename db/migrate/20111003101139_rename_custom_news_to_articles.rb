class RenameCustomNewsToArticles < ActiveRecord::Migration
  def up
    rename_table :custom_news, :articles
    change_table :comments do |c|
      c.rename :custom_news_id, :article_id
    end
  end

  def down
    rename_table :articles, :custom_news
    change_table :comments do |c|
      c.rename :article_id, :custom_news_id
    end
  end
end
