module ApplicationHelper
  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    unless html_tag =~ /^<label/
      %{<div class="field error">#{html_tag}<span class="msg">#{instance.error_message.first}</span></div>}.html_safe
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

  def userpic_url(user, size)
    default_url = "#{root_url}assets/upic_default.jpg"

    if user.profile.avatar.exists?
      size_shortcut = size == 98 ? :medium : :thumb
      res = user.profile.avatar.url size_shortcut
    else
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      res = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{default_url}"
    end

    res.html_safe
  end
end
