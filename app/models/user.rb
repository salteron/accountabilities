class User < Party
  self.table_name = 'users'
  has_many :organization_users, -> { active }, as: :child
  has_many :organizations, through: :organization_users, source: :parent,
    source_type: 'Organization'
end
