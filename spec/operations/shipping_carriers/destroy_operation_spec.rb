RSpec.describe ShippingCarriers::DestroyOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:primary_key_contract) { instance_spy(PrimaryKeyContract) }

  let(:app_container_stubs) do
    Entregis::Container.stub('primary_key_contract', primary_key_contract)
  end

  describe '.call' do
    subject(:call) { operation.call(input) }
    let(:resource) { create(:shipping_carrier) }
    let(:input) { { id: resource.id, ignored_param: false } }
    let(:valid_input) { input.except(:ignored_param) }

    let(:contract_result) { validation_contract(input: valid_input) }

    before do
      allow(primary_key_contract).to receive(:call).and_return(contract_result)
    end

    it do
      call
      expect(primary_key_contract).to have_received(:call).with(input)
    end

    context 'when contract validation has failed' do
      let(:contract_result) { validation_contract(success: false) }

      it { is_expected.to be_failed.with_instance_of(Dry::Validation::Result) }
    end

    context 'when resource was successful deleted' do
      subject(:result) { call.to_result.value! }

      it { is_expected.to be_an_instance_of(ShippingCarrier) }

      its(:name) { is_expected.to eq(resource.name) }
      its(:document) { is_expected.to eq(resource.document) }

      it do
        expect { call }.to change { ShippingCarrier.count }.from(1).to(0)
      end
    end
  end
end
