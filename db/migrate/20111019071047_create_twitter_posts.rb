class CreateTwitterPosts < ActiveRecord::Migration
  def change
    create_table :twitter_posts do |t|
      t.string :title
      t.string :subject
      t.string :search
      t.string :footer_text
    end
  end
end
