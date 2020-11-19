RSpec.describe Carriers::UpdateOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:updating_contract) { instance_spy(Carriers::UpdatingContract) }

  let(:app_container_stubs) do
    Entregis::Container.stub('carriers.updating_contract', updating_contract)
  end

  describe '.call' do
    subject(:call) { operation.call(input) }
    let(:resource) { create(:carrier) }

    let(:input) do
      {
        shipping_carrier_id: resource.shipping_carrier_id,
        id: resource.id,
        status: 'busy',
        current_location: [3.4, 2.0],
        available_payload: 1,
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
      let(:input) { { id: resource.id, shipping_carrier_id: 0 } }

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordNotFound)
      end
    end

    context 'when resource creation has failed' do
      let(:valid_input) do
        input.merge(coverage_area: [[[
                      [-51.3720703125, -24.510498046875],
                      [-48.592529296875, -25.191650390625]
                    ]]]).except(:ignored_param)
      end

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(RGeo::Error::InvalidGeometry)
      end
    end

    context 'when resource updating has failed' do
      let(:input) do
        {
          id: resource.id,
          shipping_carrier_id: resource.shipping_carrier_id,
          current_location: nil
        }
      end

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordInvalid)
      end
    end

    context 'when resource was successful updated' do
      it { is_expected.to be_success.with(resource) }

      it do
        expect { call }.to change { resource.reload.status }.to(input[:status])
      end

      it do
        expect { call }.to change { resource.reload.current_location.coordinates }
          .to(input[:current_location])
      end

      it do
        expect { call }.to change { resource.reload.available_payload }
          .to(input[:available_payload])
      end
    end
  end
end
