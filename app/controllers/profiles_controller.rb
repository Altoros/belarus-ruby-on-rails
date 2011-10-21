class ProfilesController < ApplicationController
  load_and_authorize_resource

  before_filter :get_profile

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @providers = @profile.providers_data

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update_attributes params[:profile]
        format.html { redirect_to @profile, :notice => 'Profile was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => :edit }
        format.json { render :json => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1/avatar
  def avatar
    @profile.update_attributes(:avatar => nil)
    @profile.user.reload
    @image_src = userpic_url(@profile.user, 98)

    respond_to do |format|
      format.js
    end
  end

  private

  def get_profile
    @profile = Profile.includes(:user).find(params[:id])
  end
end
