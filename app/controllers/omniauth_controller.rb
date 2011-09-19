class OmniauthController < ApplicationController
  def passthru
    if request.referer && !(/auth\/\w+\/callback/ =~ request.referer)
      store_location request.referer
    end
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end