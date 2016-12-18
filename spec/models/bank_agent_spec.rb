require 'rails_helper'

describe BankAgent, type: :model do
  describe 'accountability' do
    let(:bank) { create(:bank) }
    let(:agent) { create(:agent) }

    describe 'linking agent to bank as bank agent' do
      before { create(:bank_agent, parent: bank, child: agent) }
      it { expect(agent.banks).to contain_exactly(bank) }
      it { expect(agent.banks.first).to be_a(Bank) }
      it { expect(bank.agents).to contain_exactly(agent) }
      it { expect(bank.agents.first).to be_a(Agent) }

      it { expect(bank.clients).to eq [] }
      it { expect(agent.clients).to eq [] }
    end

    describe 'making invalid link' do
      let(:accountability) { build(:bank_agent, parent: agent, child: bank) }
      it { expect(accountability).to be_invalid }
    end
  end
end
