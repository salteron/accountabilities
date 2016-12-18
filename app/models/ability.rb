class Ability
  include CanCan::Ability

  def initialize(user)
    return can :manage, :all if user.is_administator?

    can :read, Organization, id: user.organization_ids
    can :read, Organization,
      id: OrganizationsAccountability.active.where(child: user.organizations).pluck(:parent_id)
    can :read, Organization,
      id: OrganizationsAccountability.active.where(parent: user.organizations).pluck(:child_id)

    can :read, User,
      id: OrganizationUser.active.where(parent: user.organizations).pluck(:child_id)

    can :create, OrganizationsAccountability, parent_id: user.organization_ids
    can :create, OrganizationsAccountability, child_id: user.organization_ids
    can :create, OrganizationUser, parent_id: user.organization_ids
    can :create, BankClient, parent_id: BankAgent.active.where(child: user.organizations).pluck(:parent_id)
  end
end
