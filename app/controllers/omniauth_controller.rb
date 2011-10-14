class OmniauthController < ApplicationController
  def passthru
    not_redirectable_urls = [%r{auth/\w+/callback}, %r{users/sign_in}, %r{users/sign_up}]
    if request.referer && not_redirectable_urls.all? {|url| request.referer !~ url}
      store_location request.referer
    end
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
  end
end