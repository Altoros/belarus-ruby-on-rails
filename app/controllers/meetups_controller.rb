class MeetupsController < ApplicationController
  def show
    @meetup = Meetup.active.recent.first
    @share = { :url => meetup_url, :title => @meetup.topic, :description => @meetup.description } if @meetup
  end
end
