class MessagesController < ApplicationController
  layout "table", :only => [:index]
  def get_unread
    count=current_user.received_messages.unread.length
    render :text => count
  end

  def archive
    @conversations = current_user.received_messages.map{|m| m.conversation.reverse}.uniq{|m| m[0].id}
  end

  def index
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
    # message.reply(params[:message])
    current_user.reply_to(message,params[:message])
  end
    

  def new
    @message = ActsAsMessageable::Message.new
  end

  def create
    @to = User.find_by_username(params[:to])
    current_user.send_message(@to, params[:message])
  end
end
