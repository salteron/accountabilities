require 'rails_helper'

describe Ability do
  let(:user_with_ability) { described_class.new(user) }
  let(:user) { create(:user) }

  describe 'administrator abilities' do
    let(:user) { create(:user, :administrator) }
    it { expect(user_with_ability).to be_able_to(:manage, :all) }
  end

  describe 'bank related abilities' do
    let(:bank) { create(:bank) }
    let(:accessible_banks) { Organization.bank.accessible_by(user_with_ability) }

    describe '#read' do
      context 'when user belongs to bank' do
        before { create(:organization_user, parent: bank, child: user) }
        it { expect(user_with_ability).to be_able_to(:show, bank) }
        it { expect(accessible_banks).to contain_exactly(bank) }
      end

      context 'when user belongs to client connected to bank' do
        let(:client) { create(:client) }
        before do
          create(:organization_user, parent: client, child: user)
          create(:bank_client, parent: bank, child: client)
        end

        it { expect(user_with_ability).to be_able_to(:show, bank) }
        it { expect(accessible_banks).to contain_exactly(bank) }
      end

      context 'when user belongs to agent connected to bank' do
        let(:agent) { create(:agent) }
        before do
          create(:organization_user, parent: agent, child: user)
          create(:bank_agent, parent: bank, child: agent)
        end

        it { expect(user_with_ability).to be_able_to(:show, bank) }
        it { expect(accessible_banks).to contain_exactly(bank) }
      end

      context 'when user does not belong to bank' do
        it { expect(user_with_ability).not_to be_able_to(:show, bank) }
        it { expect(accessible_banks).to eq [] }
      end
    end
  end

  describe 'client related abilities' do
    let(:client) { create(:client) }
    let(:accessible_clients) { Organization.client.accessible_by(user_with_ability) }

    describe '#read' do
      context 'when user belongs to client' do
        before { create(:organization_user, parent: client, child: user) }
        it { expect(user_with_ability).to be_able_to(:show, client) }
        it { expect(accessible_clients).to contain_exactly(client) }
      end

      context 'when user belongs to bank connected to client' do
        let(:bank) { create(:bank) }
        before do
          create(:organization_user, parent: bank, child: user)
          create(:bank_client, parent: bank, child: client)
        end

        it { expect(user_with_ability).to be_able_to(:show, client) }
        it { expect(accessible_clients).to contain_exactly(client) }
      end

      context 'when user belongs to agent connected to client' do
        let(:agent) { create(:agent) }
        before do
          create(:organization_user, parent: agent, child: user)
          create(:client_agent, parent: client, child: agent)
        end

        it { expect(user_with_ability).to be_able_to(:show, client) }
        it { expect(accessible_clients).to contain_exactly(client) }
      end

      context 'when user does not belong to client' do
        it { expect(user_with_ability).not_to be_able_to(:show, client) }
        it { expect(accessible_clients).to eq [] }
      end
    end
  end

  describe 'agent related abilities' do
    let(:agent) { create(:agent) }
    let(:accessible_agents) { Organization.agent.accessible_by(user_with_ability) }

    describe '#read' do
      context 'when user belongs to agent' do
        before { create(:organization_user, parent: agent, child: user) }
        it { expect(user_with_ability).to be_able_to(:show, agent) }
        it { expect(accessible_agents).to contain_exactly(agent) }
      end

      context 'when user belongs to bank connected to agent' do
        let(:bank) { create(:bank) }
        before do
          create(:organization_user, parent: bank, child: user)
          create(:bank_agent, parent: bank, child: agent)
        end

        it { expect(user_with_ability).to be_able_to(:show, agent) }
        it { expect(accessible_agents).to contain_exactly(agent) }
      end

      context 'when user belongs to client connected to agent' do
        let(:client) { create(:client) }
        before do
          create(:organization_user, parent: client, child: user)
          create(:client_agent, parent: client, child: agent)
        end

        it { expect(user_with_ability).to be_able_to(:show, agent) }
        it { expect(accessible_agents).to contain_exactly(agent) }
      end

      context 'when user does not belong to agent' do
        it { expect(user_with_ability).not_to be_able_to(:show, agent) }
        it { expect(accessible_agents).to eq [] }
      end
    end
  end

  describe 'user related abilities' do
    let(:another_user) { create(:user) }
    let(:accessible_users) { User.accessible_by(user_with_ability) }
    let(:bank) { create(:bank) }

    context 'when users belong to the same organization' do
      before do
        create(:organization_user, parent: bank, child: user)
        create(:organization_user, parent: bank, child: another_user)
      end
      it { expect(user_with_ability).to be_able_to(:show, another_user) }
      it { expect(accessible_users).to contain_exactly(user, another_user) }
    end

    context 'when user does not belong to the same organization' do
      before do
        create(:organization_user, parent: bank, child: user)
        create(:organization_user, child: another_user)
      end
      it { expect(user_with_ability).not_to be_able_to(:show, another_user) }
      it { expect(accessible_users).to contain_exactly(user) }
    end
  end

  describe 'BankClient related abilities' do
    describe '#create' do
      let(:bank_client) { build(:bank_client, parent: bank) }
      let(:bank) { create(:bank) }

      context 'when user belongs to bank' do
        before { create(:organization_user, parent: bank, child: user) }
        it { expect(user_with_ability).to be_able_to(:create, bank_client) }
      end

      context 'when user belongs to agent connected to bank' do
        let(:agent) { create(:agent) }
        before do
          create(:organization_user, parent: agent, child: user)
          create(:bank_agent, parent: bank, child: agent)
        end

        it { expect(user_with_ability).to be_able_to(:create, bank_client) }
      end

      context 'when user belongs to client connected to bank' do
        let(:client) { create(:client) }
        before do
          create(:organization_user, parent: client, child: user)
          create(:bank_client, parent: bank, child: client)
        end

        it { expect(user_with_ability).not_to be_able_to(:create, bank_client) }
      end

      context 'when user does not belong to bank' do
        it { expect(user_with_ability).not_to be_able_to(:create, bank_client) }
      end
    end
  end

  describe 'BankAgent related abilities' do
    describe '#create' do
      let(:bank_agent) { build(:bank_agent, parent: bank, child: agent) }
      let(:bank) { create(:bank) }
      let(:agent) { create(:agent) }

      context 'when user belongs to bank' do
        before { create(:organization_user, parent: bank, child: user) }
        it { expect(user_with_ability).to be_able_to(:create, bank_agent) }
      end

      context 'when user belongs to agent' do
        before { create(:organization_user, parent: agent, child: user) }
        it { expect(user_with_ability).to be_able_to(:create, bank_agent) }
      end

      context 'when user does not belong nor to bank neither agent' do
        it { expect(user_with_ability).not_to be_able_to(:create, bank_agent) }
      end
    end
  end

  describe 'ClientAgent related abilities' do
    describe '#create' do
      let(:client_agent) { build(:client_agent, parent: client, child: agent) }
      let(:client) { create(:client) }
      let(:agent) { create(:agent) }

      context 'when user belongs to client' do
        before { create(:organization_user, parent: client, child: user) }
        it { expect(user_with_ability).to be_able_to(:create, client_agent) }
      end

      context 'when user belongs to agent' do
        before { create(:organization_user, parent: agent, child: user) }
        it { expect(user_with_ability).to be_able_to(:create, client_agent) }
      end

      context 'when user does not belong to bank' do
        it { expect(user_with_ability).not_to be_able_to(:create, client_agent) }
      end
    end
  end

  describe 'OrganizationUser related abilities' do
    describe '#create' do
      let(:new_user) { create(:user, id: 42) }
      let(:organization_user) { build(:organization_user, parent: bank, child: new_user) }
      let(:bank) { create(:bank) }

      context 'when user belongs to organization' do
        before { create(:organization_user, parent: bank, child: user) }
        it { expect(user_with_ability).to be_able_to(:create, organization_user) }
      end

      context 'when user does not belong to organization' do
        before { create(:organization_user, parent: create(:bank, id: 42), child: user) }
        it { expect(user_with_ability).not_to be_able_to(:create, organization_user) }
      end
    end
  end

  describe 'accountability #is_active influence' do
    let(:user) { create(:user) }
    let(:bank) { create(:bank) }
    let(:client) { create(:client) }
    let!(:organization_user) { create(:organization_user, parent: client, child: user) }
    let!(:bank_client) { create(:bank_client, parent: bank, child: client) }

    it { expect(user_with_ability).to be_able_to(:read, client) }
    it { expect(user_with_ability).to be_able_to(:read, bank) }

    context 'when organization user becomes inactive' do
      before { organization_user.update(is_active: false) }
      it { expect(user_with_ability).not_to be_able_to(:read, client) }
      it { expect(user_with_ability).not_to be_able_to(:read, bank) }
    end

    context 'when bank client becomes inactive' do
      before { bank_client.update(is_active: false) }
      it { expect(user_with_ability).to be_able_to(:read, client) }
      it { expect(user_with_ability).not_to be_able_to(:read, bank) }
    end
  end
end
