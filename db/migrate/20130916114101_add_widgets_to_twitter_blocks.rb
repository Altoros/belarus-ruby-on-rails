class AddWidgetsToTwitterBlocks < ActiveRecord::Migration
  def change
    add_column :twitter_blocks, :widget, :string, null: false, default: ''
  end
end
