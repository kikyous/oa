#!/bin/env ruby
# encoding: utf-8
module UnpaidDebtsHelper
    def debts_status(i)
        debts_status_list.insert(0,'等待中')[i]
    end
    def debts_status_list
        ['同意','不同意','已付']
    end
    def debts_status_select
        debts_status_list.zip(1..debts_status_list.length)
    end
end
