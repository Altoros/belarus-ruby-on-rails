class WelcomeController < ApplicationController
  #before_filter :authenticate_user!

  def index
    unless user_signed_in?
      #deny_access
    end
  end

end
