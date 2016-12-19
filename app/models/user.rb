class User < Party
  self.table_name = 'users'
  enum role: %i[user administrator]

  has_many :organization_users, -> { organization_user },
    class_name: Accountability, as: :child
  has_many :organizations, through: :organization_users, source: :parent,
    source_type: 'Organization'
  has_many :banks, -> { bank }, through: :organization_users, source: :parent,
    source_type: 'Organization'
  has_many :clients, -> { client }, through: :organization_users, source: :parent,
    source_type: 'Organization'
  has_many :agents, -> { agent }, through: :organization_users, source: :parent,
    source_type: 'Organization'
end
