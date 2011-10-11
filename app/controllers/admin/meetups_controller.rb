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
    @meetup = Meetup.active.recent.first
  end

  def cancel
    @meetup = Meetup.find(params[:meetup_id])
    @meetup.update_attribute(:cancelled, true)

    flash[:notice] = t('meetup.cancel_ok')
    redirect_to admin_meetups_path
  end

  def update
    @meetup = Meetup.find(params[:id])

    if @meetup.update_attributes(params[:meetup])
      flash[:notice] = t('meetup.update_ok')
      redirect_to admin_meetups_path
    else
      respond_to do |format|
        format.html  { render :action => "edit" }
        format.json  { render :json => @meetup.errors }
      end
    end
  end
end
