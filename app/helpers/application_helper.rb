module ApplicationHelper
  def store_location
    session[:user_return_to] = request.fullpath
  end
end
