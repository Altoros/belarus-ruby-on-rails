class ProfilesController < ApplicationController
  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, :notice => 'Profile was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => :edit }
        format.json { render :json => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

end
