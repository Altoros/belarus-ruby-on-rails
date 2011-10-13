class MeetupWidget < Apotomo::Widget
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
    @meetup.participants.create(:user_id => @current_user.id)
    replace :state => :display
  end

  private
    def setup!(widget)
      @meetup = Meetup.active.recent.first
      @current_user = options[:user]
    end
end
