class MeetupWidget < Apotomo::Widget
  responds_to_event :register
  after_initialize :setup!

  def display
    if @meetup
      @is_participant = @current_user ? @meetup.is_participant(@current_user.id) : false
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
