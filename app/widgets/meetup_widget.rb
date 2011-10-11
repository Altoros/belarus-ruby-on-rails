class MeetupWidget < Apotomo::Widget
  after_initialize :setup!

  def display
    if @meetup
      render
    end
  end

  def register
    replace :view => :display
  end

  private
    def setup!(widget)
      @meetup = Meetup.active.recent.first
      @current_user = options[:user]
    end
end
