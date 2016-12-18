class BankAgent < OrganizationsAccountability
  validate :parent_is_bank, :child_is_agent

  private

  def parent_is_bank
    errors.add(:parent, :inclusion) unless parent.is_a?(Bank)
  end

  def child_is_agent
    errors.add(:child, :inclusion) unless child.is_a?(Agent)
  end
end
