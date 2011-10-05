class Admin::MeetupsController < ApplicationController
  load_and_authorize_resource :class => Meetup

  def create
    @meetup=Meetup.new(params[:meetup])

    if @meetup.save
      flash[:notice]=I18n.t('meetup.create_ok')
      redirect_to admin_meetups_url
    else
      respond_to do |format|
        format.html  { render :action => "new" }
        format.json  { head :ok }
      end
    end
  end

  def index
    @meetup=Meetup.where("date_and_time > ?", Time.now).order('id DESC').first
  end
end
