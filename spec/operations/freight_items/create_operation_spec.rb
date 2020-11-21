RSpec.describe FreightItems::CreateOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:creation_contract) { instance_spy(FreightItems::CreationContract) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freight_items.creation_contract', creation_contract)
  end

  describe '.call' do
    subject(:call) { operation.call(input) }
    let(:freight) { create(:freight) }

    let(:input) do
      {
        freight_id: freight.id,
        cubic_meters: 12,
        weight: 100,
      }
    end

    let(:valid_input) { input }

    let(:contract_result) { validation_contract(input: valid_input) }

    before do
      allow(creation_contract).to receive(:call).and_return(contract_result)
    end

    it do
      call
      expect(creation_contract).to have_received(:call).with(input)
    end

    context 'when contract validation has failed' do
      let(:contract_result) { validation_contract(success: false) }

      it { is_expected.to be_failed.with_instance_of(Dry::Validation::Result) }
    end

    context 'when resource creation has failed' do
      let(:valid_input) { input.merge(weight: 0) }

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordInvalid)
      end
    end

    context 'when resource was successful created' do
      subject(:result) { call.to_result.value! }

      it { is_expected.to be_an_instance_of(FreightItem) }

      its(:cubic_meters) { is_expected.to eq(input[:cubic_meters]) }
      its(:weight) { is_expected.to eq(input[:weight]) }
      its(:freight_id) { is_expected.to eq(input[:freight_id]) }

      it do
        expect { call }.to change { FreightItem.count }.by(1)
      end
    end
  end
end
