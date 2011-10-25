module ApplicationHelper
  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    unless html_tag =~ /^<label/
      %{<div class="field error">#{html_tag}<span class="msg">#{instance.object.class.human_attribute_name(instance.method_name)} #{instance.error_message.first}</span></div>}.html_safe
    else
      %{#{html_tag}}.html_safe
    end
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
