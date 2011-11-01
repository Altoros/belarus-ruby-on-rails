class MeetupWidget < Apotomo::Widget
  include Sprockets::Helpers::RailsHelper

  responds_to_event :register
  after_initialize :setup!

  DESCRIPTION_LENGTH = 300
  DESCRIPTION_OMISSION = '<span id="meetup-omission">...</span>'

  def display
    if @meetup
      @share = { :title => @meetup.topic, :description => @meetup.description }
      @is_participant = @meetup.participant? @current_user

      render
    end
  end

  def register
    participant = @meetup.participants.create(:user_id => @current_user.id)
    render :text => "$('.attend_button').replaceWith($('<img src=\"#{ asset_path('you-participate.png') }\" />'))" if participant
  end

  def self.description_html(description, length = 300)
    res = ''
    truncated_description = truncate(description, :length => length, :separator => ' ', :omission => '<span id="meetup-omission">...</span>')
    another_part = description.gsub(truncated_description[0..-38], '')
    res << "<p>#{ truncated_description }"
    res << "<a href='#' id='meetup-read-more'>More</a>"
    res << "<span id='meetup-description-full' style='display: none;'>#{ another_part }</span></p>"
    res.html_safe
  end

  private
    def setup!(widget)
      @meetup = Meetup.active.recent.first
      @current_user = options[:user]
    end
end
