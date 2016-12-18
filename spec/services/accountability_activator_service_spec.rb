require 'rails_helper'

describe AccountabilityActivatorService do
  let(:service) { described_class.new(accountability) }

  describe '#activate' do
    let(:activate) { service.activate }

    context 'when not activated yet' do
      let(:accountability) { create(:bank_client, activated_at: nil) }

      it do
        expect { activate }.to change \
          { accountability.reload.activated_at }.to be_present
      end
    end

    context 'when already activated' do
      let(:accountability) { create(:organization_user, activated_at: 1.year.ago) }
      it { expect { activate }.not_to change { accountability.reload.activated_at } }
    end
  end
end
