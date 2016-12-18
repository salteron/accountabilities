class BankClient < OrganizationsAccountability
  validate :parent_is_bank, :child_is_client

  private

  def parent_is_bank
    errors.add(:parent, :inclusion) unless parent.is_a?(Bank)
  end

  def child_is_client
    errors.add(:child, :inclusion) unless child.is_a?(Client)
  end
end
