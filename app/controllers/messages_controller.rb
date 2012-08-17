class MessagesController < ApplicationController
  before_filter :authenticate_user!
  layout "table", :only => [:index]
  def get_unread
    count=current_user.received_messages.unread.length
    render :text => count
  end

  def archive
    id=params[:id].to_i * 10
    @conversations = current_user.messages.where(:ancestry => nil).limit(10).offset(id)
    @count=current_user.messages.where(:ancestry => nil).count

  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: MessagesDatatable.new(view_context,current_user) }
    end
  end
  def show
    message=current_user.messages.with_id(params[:id])
    @conversation=message.first.conversation.reverse
    @conversation.each do |m|
      m.mark_as_read unless m.opened
    end

  end

  def reply
    message=current_user.messages.with_id(params[:conversation]).first
    
    respond_to do |format|
      if reply=current_user.reply_to(message,params[:message])
        format.html { render :partial => "message", :locals => { :message => reply } }
      else
        format.html { render :text => "error occur!" }
      end
    end
  end
    

  def new
    @message = ActsAsMessageable::Message.new
  end

  def create
    @to = User.find(params[:main][:to])
    respond_to do |format|
      if message=current_user.send_message(@to, params[:message])
        format.html { redirect_to "/messages/#{message.id}" }
      else
        format.html { render :text => "error occur!" }
      end
    end
  end
end
