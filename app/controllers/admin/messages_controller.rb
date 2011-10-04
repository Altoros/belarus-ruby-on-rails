class Admin::MessagesController < ApplicationController
  load_and_authorize_resource

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      # TODO send message here
      redirect_to admin_root_url, :notice => I18n.t('admin.messages.successfully_sent')
    else
      render :action => 'new'
    end
  end
end
