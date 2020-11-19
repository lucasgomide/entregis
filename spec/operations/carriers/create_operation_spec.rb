RSpec.describe Carriers::CreateOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:creation_contract) { instance_spy(Carriers::CreationContract) }
  let(:creation_builder) { instance_spy(Freights::CreationBuilder) }

  let(:app_container_stubs) do
    Entregis::Container.stub('carriers.creation_contract', creation_contract)
    Entregis::Container.stub('carriers.creation_builder', creation_builder)
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
    let(:build_result) do
      success(
        valid_input.merge(
          coverage_area: coordiantes_to_wkt(valid_input[:coverage_area], 'MultiPolygon'),
          current_location: coordiantes_to_wkt(valid_input[:current_location]),
          available_cubic_meters: vehicle.cubic_meters_capacity,
          available_payload: vehicle.payload_capacity
        )
      )
    end

    before do
      allow(creation_contract).to receive(:call).and_return(contract_result)
      allow(creation_builder).to receive(:build_attributes).and_return(build_result)
    end

    it do
      call
      expect(creation_contract).to have_received(:call).with(input)
    end

    it do
      call
      aggregate_failures do
        expect(creation_builder).to have_received(:from_params).with(contract_result.to_h)
        expect(creation_builder).to have_received(:build_attributes)
      end
    end

    context 'when contract validation has failed' do
      let(:contract_result) { validation_contract(success: false) }

      it { is_expected.to be_failed.with_instance_of(Dry::Validation::Result) }
    end

    context 'when builder has failed' do
      let(:error) { 'any error' }
      let(:build_result) { failure(error) }

      it { is_expected.to be_failed.with(error) }
    end

    context 'when resource creation has failed' do
      let(:build_result) do
        success(
          valid_input.merge(
            coverage_area: coordiantes_to_wkt(
              valid_input[:coverage_area], 'MultiPolygon'
            ),
            current_location: nil
          )
        )
      end

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordInvalid)
      end
    end

    context 'when resource was successful created' do
      subject(:result) { call.to_result.value! }

      it { is_expected.to be_an_instance_of(Carrier) }

      its('current_location.coordinates') { is_expected.to eq(input[:current_location]) }
      its(:vehicle_id) { is_expected.to eq(input[:vehicle_id]) }
      its(:status) { is_expected.to eq(input[:status]) }
      its(:km_price_cents) { is_expected.to eq(input[:km_price_cents]) }
      its(:weight_price_cents) { is_expected.to eq(input[:weight_price_cents]) }
      its(:available_cubic_meters) { is_expected.to eq(vehicle.cubic_meters_capacity) }
      its(:available_payload) { is_expected.to eq(vehicle.payload_capacity) }

      it do
        expect { call }.to change { Carrier.count }.by(1)
      end
    end
  end
end
