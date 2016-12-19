class Organization < Party
  self.table_name = 'organizations'
  enum role: %i[bank client agent]

  has_many :organization_users, -> { organization_user },
    class_name: Accountability, as: :parent
  has_many :users, through: :organization_users, source: :child,
    source_type: 'User'

  has_many :bank_clients, -> { bank_client },
    class_name: Accountability, as: :parent
  has_many :client_banks, -> { bank_client },
    class_name: Accountability, as: :child

  has_many :bank_agents, -> { bank_agent },
    class_name: Accountability, as: :parent
  has_many :agent_banks, -> { bank_agent },
    class_name: Accountability, as: :child

  has_many :client_agents, -> { client_agent },
    class_name: Accountability, as: :parent
  has_many :agent_clients, -> { client_agent },
    class_name: Accountability, as: :child

  def clients
    if bank?
      Organization.where(id: bank_clients.select(:child_id))
    else
      Organization.where(id: agent_clients.select(:parent_id))
    end
  end

  def banks
    if client?
      Organization.where(id: client_banks.select(:parent_id))
    else
      Organization.where(id: agent_banks.select(:parent_id))
    end
  end

  def agents
    if client?
      Organization.where(id: client_agents.select(:child_id))
    else
      Organization.where(id: bank_agents.select(:child_id))
    end
  end
end
