module ApplicationHelper
  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    unless html_tag =~ /^<label/
      # FIXME instance does not expose method_name anymore. There must be a better way to handle errors.
      method_name = instance.instance_variable_get(:@method_name)
      field_name = instance.object.class.human_attribute_name(method_name)
      error_message = instance.error_message.first

      %{<div class="field error">#{html_tag}<span class="msg">#{field_name} #{error_message}</span></div>}.html_safe
    else
      %{#{html_tag}}.html_safe
    end
  end

  def current_user_is_participant?(meetup_id)
    Participant.where({:user_id => current_user.id, :meetup_id => meetup_id}).length > 0
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

  def static_page_links
    html = StaticPage.all.inject('') do |res, page|
      res << "<li>#{ link_to_unless_current t("menu.#{page.permalink}"), static_page_path(:permalink => page.permalink) }</li>"
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

  def button_inner_html(text)
    "<span><span>#{ text }</span></span>".html_safe
  end

  def unsubscribe_link(email, html = false)
    user = User.find_by_email(email)
    if user
      unsubscribe_url = unsubscribe_url(:token => user.unsubscribe_token, :email => user.email)
      if html
        link_to("unsubscribe", unsubscribe_url)
      else
        "unsubscribe " + unsubscribe_url
      end
    end
  end

end
