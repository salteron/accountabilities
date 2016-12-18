class Agent < Organization
  has_many :bank_agents, as: :child
  has_many :banks, through: :bank_agents, source: :parent,
    source_type: 'Organization'
  has_many :client_agents, as: :child
  has_many :clients, through: :client_agents, source: :parent,
    source_type: 'Organization'
end
