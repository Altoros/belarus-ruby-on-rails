require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ProfilesController do

  # This should return the minimal set of attributes required to create a valid
  # Profile. As you add validations to Profile, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    Factory.build(:profile)
  end

  describe "GET show" do
    it "assigns the requested profile as @profile" do
      user = Factory(:user)
      get :show, :id => user.profile.id
      assigns(:profile).should eq(user.profile)
    end
  end

  describe "GET edit" do
    it "assigns the requested profile as @profile" do
      user = Factory(:user)
      get :edit, :id => user.profile.id
      assigns(:profile).should eq(user.profile)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested profile" do
        user = Factory(:user)
        # Assuming there are no other profiles in the database, this
        # specifies that the Profile created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Profile.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => user.profile.id, :profile => {'these' => 'params'}
      end

      it "assigns the requested profile as @profile" do
        user = Factory(:user)
        put :update, :id => user.profile.id, :profile => valid_attributes
        assigns(:profile).should eq(user.profile)
      end

      it "redirects to the profile" do
        user = Factory(:user)
        put :update, :id => user.profile.id, :profile => valid_attributes
        response.should redirect_to(user.profile)
      end
    end

    describe "with invalid params" do
      it "assigns the profile as @profile" do
        user = Factory(:user)
        # Trigger the behavior that occurs when invalid params are submitted
        Profile.any_instance.stub(:save).and_return(false)
        put :update, :id => user.profile.id, :profile => {}
        assigns(:profile).should eq(user.profile)
      end

      it "re-renders the 'edit' template" do
        user = Factory(:user)
        # Trigger the behavior that occurs when invalid params are submitted
        Profile.any_instance.stub(:save).and_return(false)
        put :update, :id => user.profile.id, :profile => {}
        response.should render_template("edit")
      end
    end
  end

end
