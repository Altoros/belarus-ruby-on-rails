class ChangeProviderName < ActiveRecord::Migration
  def up
    UserToken.update_all({:provider => 'linkedin'}, {:provider => 'linked_in'})
  end

  def down
    UserToken.update_all({:provider => 'linked_in'}, {:provider => 'linkedin'})
  end
end
