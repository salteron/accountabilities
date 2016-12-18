class OrganizationUser < Accountability
  validates :parent_type, inclusion: {in: %w[Organization]}
  validates :child_type, inclusion: {in: %w[User]}
end
