RSpec.describe FreightItems::UpdateOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:updating_contract) { instance_spy(FreightItems::UpdatingContract) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freight_items.updating_contract', updating_contract)
  end

  describe '.call' do
    subject(:call) { operation.call(input) }
    let(:resource) { create(:freight_item) }

    let(:input) do
      {
        freight_id: resource.freight_id,
        id: resource.id,
        cubic_meters: 1000,
        weight: 40,
        ignored_param: false
      }
    end
    let(:valid_input) { input.except(:ignored_param) }

    let(:contract_result) { validation_contract(input: valid_input) }

    before do
      allow(updating_contract).to receive(:call).and_return(contract_result)
    end

    it do
      call
      expect(updating_contract).to have_received(:call).with(input)
    end

    context 'when contract validation has failed' do
      let(:contract_result) { validation_contract(success: false) }

      it { is_expected.to be_failed.with_instance_of(Dry::Validation::Result) }
    end

    context 'when resource was not found' do
      let(:input) { { id: resource.id, freight_id: 0 } }

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordNotFound)
      end
    end

    context 'when resource updating has failed' do
      let(:input) do
        {
          id: resource.id,
          freight_id: resource.freight_id,
          cubic_meters: nil
        }
      end

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordInvalid)
      end
    end

    context 'when resource was successful updated' do
      it { is_expected.to be_success.with(resource) }

      it do
        expect { call }.to change { resource.reload.cubic_meters }.to(input[:cubic_meters])
      end

      it do
        expect { call }.to change { resource.reload.weight }.to(input[:weight])
      end
    end
  end
end
