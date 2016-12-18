class ClientAgent < OrganizationsAccountability
  validate :parent_is_client, :child_is_agent

  private

  def parent_is_client
    errors.add(:parent, :inclusion) unless parent.is_a?(Client)
  end

  def child_is_agent
    errors.add(:child, :inclusion) unless child.is_a?(Agent)
  end
end
