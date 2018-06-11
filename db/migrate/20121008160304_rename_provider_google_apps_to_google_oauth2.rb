class RenameProviderGoogleAppsToGoogleOauth2 < ActiveRecord::Migration
  def up
    UserToken.update_all(provider: 'google_oauth2')
  end

  def down
    UserToken.update_all(provider: 'google_apps')
  end
end
