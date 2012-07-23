class Ability
  include CanCan::Ability

  def initialize(user)
      p "##########################################################################################"
    
      user ||= User.new # guest user (not logged in)
      ga= user.groups.map{|g| g.org_group_access}
      ua= user.groups.map{|u| u.org_user_access}

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

  end
end
