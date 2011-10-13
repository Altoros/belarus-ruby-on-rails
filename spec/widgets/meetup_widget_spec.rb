require 'spec_helper'

describe MeetupWidget do
  let(:rendered_meetup) { render_widget(:meetup) }

  context 'active meetup is exist' do
    before(:each) do
      @meetup = Factory :meetup
    end

    describe '#display' do
      has_widgets do |root|
        root << widget(:meetup)
      end

      it 'contain meetup information' do
        rendered_meetup.should have_content(@meetup.topic)
      end

      it 'contain \'Share\' buttons' do
        rendered_meetup.should have_selector('div.addthis_toolbox')
      end

      it 'unvailible to register for signed out user' do
        rendered_meetup.should_not have_link('Register to meetup')
        rendered_meetup.should have_link('Login')
      end

      context 'signed in user' do
        let(:user) { Factory.stub(:user) }
        has_widgets do |root|
          root << widget(:meetup, :user => user)
        end

        it 'availible to attend' do
          rendered_meetup.should have_link('Register to meetup')
        end

        it 'attending a meetup' do
          trigger(:register, :meetup).first.should include('You are participant !!!')
        end
      end
    end
  end

  context 'active meetup isn\'t exist' do
    describe '#display' do
      has_widgets do |root|
        root << widget(:meetup)
      end

      it 'don\'t contain any information' do
        render_widget(:meetup).native.should be_nil
      end
    end
  end
end
