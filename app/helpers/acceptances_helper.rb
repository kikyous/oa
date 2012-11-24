#!/bin/env ruby
# encoding: utf-8
module AcceptancesHelper
    def status(s)
        if s.to_i==1
            return '已支付'
        else
            return '未支付'
        end
    end
    def showpayto(key)
      return "无" unless key
      key.payto
    end
end
