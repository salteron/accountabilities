class Ability
  include CanCan::Ability

  def initialize(user)
    return can :manage, :all if user.administrator?

    active_organization_ids = user.organizations.where(accountabilities: {is_active: true}).ids

    can :read, Organization, id: active_organization_ids
    can :read, Organization,
      id: Accountability.b2b.active.where(child: active_organization_ids).pluck(:parent_id)
    can :read, Organization,
      id: Accountability.b2b.active.where(parent: active_organization_ids).pluck(:child_id)

    can :read, User,
      id: Accountability.organization_user.active.where(parent: active_organization_ids).pluck(:child_id)

    can :create, Accountability,
      role: %w[bank_client client_agent bank_agent],
      parent_id: active_organization_ids
    can :create, Accountability,
      role: %w[bank_client client_agent bank_agent],
      child_id: active_organization_ids

    can :create, Accountability,
      role: 'organization_user',
      parent_id: active_organization_ids

    can :create, Accountability,
      role: 'bank_client',
      parent_id: Accountability.bank_agent.where(child: active_organization_ids).pluck(:parent_id)
  end
end
