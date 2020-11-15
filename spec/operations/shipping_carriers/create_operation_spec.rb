RSpec.describe ShippingCarriers::CreateOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:creation_contract) { instance_spy(ShippingCarriers::CreationContract) }

  let(:app_container_stubs) do
    Entregis::Container.stub('shipping_carriers.creation_contract', creation_contract)
  end

  describe '.call' do
    subject(:call) { operation.call(input) }

    let(:input) { { id: 23, name: 'New name', document: '000000', ignored_param: false } }
    let(:valid_input) { input.except(:ignored_param, :id) }

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
      let(:valid_input) { { name: nil } }

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordInvalid)
      end
    end

    context 'when resource was successful created' do
      subject(:resul) { call.to_result.value! }

      it { is_expected.to be_an_instance_of(ShippingCarrier) }

      its(:name) { is_expected.to eq(input[:name]) }
      its(:document) { is_expected.to eq(input[:document]) }

      it do
        expect { call }.to change { ShippingCarrier.count }.by(1)
      end
    end
  end
end
