require 'rails_helper'

describe ClientAgent, type: :model do
  describe 'accountability' do
    let(:client) { create(:client) }
    let(:agent) { create(:agent) }

    describe 'linking agent to client as client agent' do
      before { create(:client_agent, parent: client, child: agent) }
      it { expect(agent.clients).to contain_exactly(client) }
      it { expect(agent.clients.first).to be_a(Client) }
      it { expect(client.agents).to contain_exactly(agent) }
      it { expect(client.agents.first).to be_a(Agent) }
    end

    describe 'making invalid link' do
      let(:accountability) { build(:client_agent, parent: agent, child: client) }
      it { expect(accountability).to be_invalid }
    end
  end
end
