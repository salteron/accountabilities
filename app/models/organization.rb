class Organization < Party
  self.table_name = 'organizations'
  has_many :organization_users, as: :parent
  has_many :users, through: :organization_users, source: :child,
    source_type: 'User'
end
