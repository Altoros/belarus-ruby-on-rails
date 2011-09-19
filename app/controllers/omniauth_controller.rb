class OmniauthController < ApplicationController
  def passthru
    if request.referer && request.referer !~ %r{auth/\w+/callback}
      store_location request.referer
    end
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
  end
end
