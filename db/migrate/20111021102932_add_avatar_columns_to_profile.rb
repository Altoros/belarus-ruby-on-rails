class AddAvatarColumnsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :avatar_file_name, :string
    add_column :profiles, :avatar_content_type, :string
    add_column :profiles, :avatar_file_size, :integer
    add_column :profiles, :avatar_updated_at, :datetime
  end
end
