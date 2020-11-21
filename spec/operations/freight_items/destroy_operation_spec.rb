RSpec.describe FreightItems::DestroyOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:deleting_contract) { instance_spy(FreightItems::DeletingContract) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freight_items.deleting_contract', deleting_contract)
  end

  describe '.call' do
    subject(:call) { operation.call(input) }
    let(:resource) { create(:freight_item) }
    let(:input) do
      {
        id: resource.id,
        freight_id: resource.freight_id,
        ignored_param: false
      }
    end
    let(:valid_input) { input.except(:ignored_param) }

    let(:contract_result) { validation_contract(input: valid_input) }

    before do
      allow(deleting_contract).to receive(:call).and_return(contract_result)
    end

    it do
      call
      expect(deleting_contract).to have_received(:call).with(input)
    end

    context 'when contract validation has failed' do
      let(:contract_result) { validation_contract(success: false) }

      it { is_expected.to be_failed.with_instance_of(Dry::Validation::Result) }
    end

    context 'when resource was successful deleted' do
      subject(:result) { call.to_result.value! }

      it { is_expected.to be_an_instance_of(FreightItem) }

      it do
        expect { call }.to change { FreightItem.count }.from(1).to(0)
      end
    end
  end
end
