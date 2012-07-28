#!/bin/env ruby
# encoding: utf-8

module MessagesHelper
  def find_user(id)
    User.find(id)
  end

  def msg_status(msg)
    if msg.opened
      return "已读"   
    else
      return "有新信息"
    end
  end
end
