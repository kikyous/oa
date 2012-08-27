#!/bin/env ruby
# encoding: utf-8
class Ability
  include CanCan::Ability

  def initialize(user)
    
      user ||= User.new # guest user (not logged in)
      ga= user.groups.map{|g| g.org_group_access}
      ua= user.groups.map{|u| u.org_user_access}
      gids= user.groups.map(&:id)

      if ga.map{|g| g.include?"C"}.include?true
        can :create, Group
      end
      if ga.map{|g| g.include?"R"}.include?true
        can :read, Group
      end
      if ga.map{|g| g.include?"U"}.include?true
        can :update, Group
      end
      if ga.map{|g| g.include?"D"}.include?true
        can :destroy, Group
      end

      if ua.map{|g| g.include?"C"}.include?true
        can :create, User
      end
      if ua.map{|g| g.include?"R"}.include?true
        can :read, User
      end
      if ua.map{|g| g.include?"U"}.include?true
        can :update, User
      end
      if ua.map{|g| g.include?"D"}.include?true
        can :destroy, User
      end

      #总经理
      if gids.include?2
        can :manage, [Announcement]
      end

      #供销部
      if gids.include?3
        can :manage, [Supplier,SuplContract,SalesContract]
      end

      #财务部
      if gids.include?4 or gids.include?2
        can :manage, [Attendance,BankAccount,Expenditure,InCome,Acceptance,Transfer,UnpaidDebt,Reimbursement]
      end

      #库房
      if gids.include?5
        can :manage, [InStore,OutStore]
      end

      #车间
      if gids.include?6
        can :manage, [Task,Delivery]
      end

  end
end
