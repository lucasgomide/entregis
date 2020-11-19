RSpec.describe Carriers::CreationBuilder, type: :builder do
  subject(:builder) { described_class.new }

  describe '.build_attributes' do
    subject(:build_attributes) { builder.from_params(input).build_attributes }
    let(:valid_input) do
      {
        current_location: [1, 3],
          coverage_area: [[[
          [-51.61376953125, -15.2490234375],
          [-39.92431640625, -15.6884765625],
          [-51.52587890625, -29.091796875],
          [-57.32666015625, -17.9296875],
          [-56.97509765625, -13.8427734375],
          [-51.61376953125, -15.2490234375]
        ]]],
        vehicle_id: vehicle.id,
      }
    end
    let(:vehicle) { create(:vehicle) }

    context 'when the process to convert coordinates to RGeo Point has failed' do
      subject(:success) { build_attributes.to_result }

      context 'with coverage_area' do
        let(:input) do
          valid_input.merge(current_location: [1, 3], coverage_area: [[[[1, 2]]]])
        end
        it { is_expected.to be_failed.with_instance_of(RGeo::Error::InvalidGeometry) }
      end
    end

    context 'when the vehicle is not found' do
      subject(:success) { build_attributes.to_result }
      let(:input) do
        valid_input.merge(vehicle_id: 0)
      end

      it { is_expected.to be_failed.with_instance_of(ActiveRecord::RecordNotFound) }
    end

    context 'when the process to convert coordinates to RGeo Point has successful' do
      subject(:success) { build_attributes.value! }

      let(:input) { valid_input }

      its([:current_location]) do
        is_expected.to be_an_instance_of(RGeo::Cartesian::PointImpl)
      end
      its([:coverage_area]) do
        is_expected.to be_an_instance_of(RGeo::Cartesian::MultiPolygonImpl)
      end

      context 'when the vehicle_id is present' do
        let(:input) { valid_input.merge(vehicle_id: vehicle.id) }

        its([:available_cubic_meters]) do
          is_expected.to eq(vehicle.cubic_meters_capacity)
        end
        its([:available_payload]) { is_expected.to eql(vehicle.payload_capacity) }
      end

      context 'when the vehicle_id not is present' do
        context 'when the available payload or available_cubic_meters is not present' do
          let(:input) do
            valid_input.except(:vehicle_id, :available_payload, :available_cubic_meters)
          end

          it { is_expected.not_to include(:available_payload, :available_cubic_meters) }
        end

        context 'when the available payload or available_cubic_meters is present' do
          let(:input) do
            valid_input.except(:vehicle_id)
                       .merge(available_payload: 2, available_cubic_meters: 1)
          end

          its([:available_cubic_meters]) do
            is_expected.to eq(input[:available_cubic_meters])
          end
          its([:available_payload]) { is_expected.to eql(input[:available_payload]) }
        end
      end
    end
  end
end
