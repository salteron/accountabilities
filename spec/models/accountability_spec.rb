require 'rails_helper'

describe Accountability, type: :model do
  describe 'organization user accountability' do
    let(:user) { create(:user) }
    let(:organization) { create(:bank) }
    let!(:organization_user) do
      create(:organization_user, parent: organization, child: user)
    end

    it { expect(organization_user).to be_valid }
    it { expect(user.organizations).to contain_exactly(organization) }
    it { expect(user.banks).to contain_exactly(organization) }
    it { expect(user.clients).to eq [] }
    it { expect(user.agents).to eq [] }
    it { expect(organization.users).to contain_exactly(user) }

    context 'when child is not user' do
      let(:organization_user) do
        build(:organization_user, parent: organization, child: create(:organization))
      end
      it { expect(organization_user).not_to be_valid }
    end

    context 'when parent is not organization' do
      let(:organization_user) do
        build(:organization_user, parent: create(:user), child: user)
      end
      it { expect(organization_user).not_to be_valid }
    end
  end

  describe 'organization accountability' do
    let(:bank) { create(:bank) }
    let(:client) { create(:client) }
    let(:agent) { create(:agent) }
    before do
      create(:bank_client, parent: bank, child: client)
      create(:bank_agent, parent: bank, child: agent)
      create(:client_agent, parent: client, child: agent)
    end

    it { expect(bank.clients).to contain_exactly(client) }
    it { expect(client.banks).to contain_exactly(bank) }

    it { expect(client.agents).to contain_exactly(agent) }
    it { expect(agent.clients).to contain_exactly(client) }

    it { expect(bank.agents).to contain_exactly(agent) }
    it { expect(agent.banks).to contain_exactly(bank) }
  end
end
