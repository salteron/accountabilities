class Bank < Organization
  has_many :bank_clients, as: :parent
  has_many :clients, through: :bank_clients, source: :child,
    source_type: 'Organization'
  has_many :bank_agents, as: :parent
  has_many :agents, through: :bank_agents, source: :child,
    source_type: 'Organization'
end
