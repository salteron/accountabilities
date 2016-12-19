class Accountability < ActiveRecord::Base
  enum role: %i[organization_user bank_client bank_agent client_agent]

  belongs_to :parent, polymorphic: true
  belongs_to :child, polymorphic: true

  scope :b2b, -> { where(role: self.roles.values_at(:bank_client, :bank_agent, :client_agent)) }
  scope :active, -> { where(is_active: true) }

  validates :parent, :child, presence: true
  validate :validate_obeying_rules

  private

  ConnectionRule = Struct.new(:accountability_role, :parent_role, :child_role)

  CONNECTION_RULES = [
    ConnectionRule.new('organization_user', 'bank', 'user'),
    ConnectionRule.new('organization_user', 'client', 'user'),
    ConnectionRule.new('organization_user', 'agent', 'user'),
    ConnectionRule.new('bank_client', 'bank', 'client'),
    ConnectionRule.new('bank_agent', 'bank', 'agent'),
    ConnectionRule.new('client_agent', 'client', 'agent')
  ]

  def validate_obeying_rules
    return nil if errors.present?
    return nil if CONNECTION_RULES.include?(
      ConnectionRule.new(role, parent.role, child.role)
    )
    errors.add(:base, :invalid)
  end
end
