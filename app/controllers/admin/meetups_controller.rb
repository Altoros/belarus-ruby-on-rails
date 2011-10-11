class Admin::MeetupsController < ApplicationController
  load_and_authorize_resource :class => Meetup

  def create
    @meetup = Meetup.new(params[:meetup])

    if @meetup.save
      flash[:notice] = t('meetup.create_ok')
      redirect_to admin_meetups_url
    else
      respond_to do |format|
        format.html  { render :action => "new" }
        format.json  { head :ok }
      end
    end
  end

  def index
    @meetup = Meetup.active.id_desc.first
  end

  def cancel
    @meetup = Meetup.find(params[:meetup_id])
    @meetup.cancelled = true
    @meetup.save

    flash[:notice] = t('meetup.cancel_ok')
    redirect_to admin_meetups_path
  end
end
