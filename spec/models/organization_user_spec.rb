require 'rails_helper'

describe OrganizationUser, type: :model do
  describe 'accountability' do
    let(:user) { create(:user) }
    let(:bank) { create(:bank) }
    let(:agent) { create(:agent) }
    let(:client) { create(:client) }

    describe 'linking user to bank as organization user' do
      before { create(:organization_user, parent: bank, child: user) }
      it { expect(user.organizations).to contain_exactly(bank) }
      it { expect(user.organizations.first).to be_a(Organization) }
      it { expect(bank.users).to contain_exactly(user) }
    end

    describe 'linking user to agent as organization user' do
      before { create(:organization_user, parent: agent, child: user) }
      it { expect(user.organizations).to contain_exactly(agent) }
      it { expect(user.organizations.first).to be_a(Organization) }
      it { expect(agent.users).to contain_exactly(user) }
    end

    describe 'linking user to client as organization user' do
      before { create(:organization_user, parent: client, child: user) }
      it { expect(user.organizations).to contain_exactly(client) }
      it { expect(user.organizations.first).to be_a(Organization) }
      it { expect(client.users).to contain_exactly(user) }
    end

    describe 'trying to make invalid link' do
      context 'when Organization-Organization' do
        let(:accountability) { build(:organization_user, parent: bank, child: agent) }
        it { expect(accountability).to be_invalid }
      end

      context 'when User-Organization' do
        let(:accountability) { build(:organization_user, parent: user, child: bank) }
        it { expect(accountability).to be_invalid }
      end

      context 'when User-User' do
        let(:accountability) { build(:organization_user, parent: user, child: another_user) }
        let(:another_user) { create(:user) }
        it { expect(accountability).to be_invalid }
      end
    end
  end
end
