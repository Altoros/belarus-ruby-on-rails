class MeetupWidget < Apotomo::Widget
  include Sprockets::Helpers::RailsHelper

  responds_to_event :register
  after_initialize :setup!

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

  private
    def setup!(widget)
      @meetup = Meetup.active.recent.first
      @current_user = options[:user]
    end
end
