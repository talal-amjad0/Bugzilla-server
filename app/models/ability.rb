# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # If user is not logged in or is a guest, allow only reading all public resources
    return unless user

    # General permission for all users (if needed)
    can :read, :all

    # Permissions for managers (can manage projects)
    if user.manager?
      can :manage, Project
      can :manage, ProjectUser

    end

    # Permissions for QA users (can manage bugs)
    if user.qa?
      can :manage, Bug
    end

    # Permissions for developers (can only view bugs)
    if user.developer?
      can :read, Bug  
      cannot :create, Bug  
      cannot :update, Bug  
      cannot :destroy, Bug  
      can :update_bug_status, Bug, assignee_id: user.id
    end
  end
end
