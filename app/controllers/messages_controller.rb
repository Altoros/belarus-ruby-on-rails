class MessagesController < ApplicationController
  load_and_authorize_resource

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      UsersFilter.emails_list(@message.recipient_group).each do |email|
        Notifier.custom(email, @message.subject, @message.body).deliver
      end
      redirect_to admin_root_url, :notice => I18n.t('admin.messages.successfully_sent')
    else
      render :action => 'new'
    end
  end
end
