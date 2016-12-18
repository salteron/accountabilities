require 'rails_helper'

describe BankClient, type: :model do
  describe 'accountability' do
    let(:bank) { create(:bank) }
    let(:client) { create(:client) }

    describe 'linking client to bank as bank client' do
      before { create(:bank_client, parent: bank, child: client) }
      it { expect(client.banks).to contain_exactly(bank) }
      it { expect(client.banks.first).to be_a(Bank) }
      it { expect(bank.clients).to contain_exactly(client) }
      it { expect(bank.clients.first).to be_a(Client) }
    end

    describe 'making invalid link' do
      let(:accountability) { build(:bank_client, parent: client, child: bank) }
      it { expect(accountability).to be_invalid }
    end
  end
end
