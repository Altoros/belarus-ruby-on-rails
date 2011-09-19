class RemoveTimestampsFromUserTokens < ActiveRecord::Migration
  def up
    remove_column :user_tokens, :created_at
    remove_column :user_tokens, :updated_at
  end

  def down
    add_column :user_tokens, :created_at, :timestamp
    add_column :user_tokens, :updated_at, :timestamp
  end
end
