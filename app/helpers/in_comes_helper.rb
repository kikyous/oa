#!/bin/env ruby
# encoding: utf-8

module InComesHelper
    def modeList
        [['现金', 1], ['承兑', 2], ['其他',0]]
    end
    def mode(index)
        modeList.map{|a,b| a }[modeList.map{|a,b| b }.index(index)]
    end
end
