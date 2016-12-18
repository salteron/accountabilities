class Client < Organization
  has_many :bank_clients, as: :child
  has_many :banks, through: :bank_clients, source: :parent,
    source_type: 'Organization'
  has_many :client_agents, as: :parent
  has_many :agents, through: :client_agents, source: :child,
    source_type: 'Organization'
end
