module ApplicationHelper
  def store_location
    session[:user_return_to] = request.fullpath
  end

  def errors_for(object, message = nil)
    html = ""
    unless object.errors.blank?
      html << "\t<div id='error_explanation'>\n"

      if message.blank?
        html << "\t\t<h2>" << pluralize(object.errors.count, "error") <<
          " prohibited this  #{object.class.name.humanize.downcase} from being saved:</h2>\n"
      else
         html << "\t\t<h2>#{message}</h5>\n"
      end

      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end

    html.html_safe
  end

end
