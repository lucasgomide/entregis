RSpec.describe Carriers::CreateOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:creation_contract) { instance_spy(Carriers::CreationContract) }

  let(:app_container_stubs) do
    Entregis::Container.stub('carriers.creation_contract', creation_contract)
  end

  describe '.call' do
    subject(:call) { operation.call(input) }
    let(:vehicle) { create(:vehicle) }
    let(:shipping_carrier) { create(:shipping_carrier) }

    let(:input) do
      {
        shipping_carrier_id: shipping_carrier.id,
        current_location: [1.1, 2.2],
        vehicle_id: vehicle.id,
        status: 'available',
        km_price_cents: 2,
        weight_price_cents: 2,
        coverage_area: [[[
          [-51.3720703125, -24.510498046875],
          [-48.592529296875, -25.191650390625],
          [-49.207763671875, -26.69677734375],
          [-51.998291015625, -25.982666015625],
          [-51.3720703125, -24.510498046875]
        ]]]
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
      let(:valid_input) { {} }

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the builder has failed' do
      let(:valid_input) { {} }

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordInvalid)
      end
    end

    context 'when resource creation has failed' do
      let(:valid_input) do
        input.merge(coverage_area: [[[
                      [-51.3720703125, -24.510498046875],
                      [-48.592529296875, -25.191650390625]
                    ]]])
      end

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(RGeo::Error::InvalidGeometry)
      end
    end

    context 'when resource was successful created' do
      subject(:resul) { call.to_result.value! }

      it { is_expected.to be_an_instance_of(Carrier) }

      its('current_location.coordinates') { is_expected.to eq(input[:current_location]) }
      its(:vehicle_id) { is_expected.to eq(input[:vehicle_id]) }
      its(:status) { is_expected.to eq(input[:status]) }
      its(:km_price_cents) { is_expected.to eq(input[:km_price_cents]) }
      its(:weight_price_cents) { is_expected.to eq(input[:weight_price_cents]) }
      its('coverage_area.coordinates') { is_expected.to eq(input[:coverage_area]) }

      it do
        expect { call }.to change { Carrier.count }.by(1)
      end
    end
  end
end
