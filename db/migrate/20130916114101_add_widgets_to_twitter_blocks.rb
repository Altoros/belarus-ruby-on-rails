class AddWidgetsToTwitterBlocks < ActiveRecord::Migration
  def change
    add_column :twitter_blocks, :widget, :text, :null => false, :default => ''
  end
end
