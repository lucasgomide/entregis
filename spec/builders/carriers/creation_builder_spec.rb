RSpec.describe Carriers::CreationBuilder, type: :builder do
  subject(:builder) { described_class.new }

  describe '.build_attributes' do
    subject(:build_attributes) { builder.from_params(input).build_attributes }

    context 'when the process to convert coordinates to RGeo Point has failed' do
      subject(:success) { build_attributes.to_result }

      context 'with coverage_area' do
        let(:input) { { current_location: [1, 3], coverage_area: [[[[1, 2]]]] } }
        it { is_expected.to be_failed.with_instance_of(RGeo::Error::InvalidGeometry) }
      end
    end

    context 'when the process to convert coordinates to RGeo Point has successful' do
      subject(:success) { build_attributes.value! }
      let(:input) do
        { current_location: [1, 3], coverage_area: [[[
          [-51.61376953125, -15.2490234375],
          [-39.92431640625, -15.6884765625],
          [-51.52587890625, -29.091796875],
          [-57.32666015625, -17.9296875],
          [-56.97509765625, -13.8427734375],
          [-51.61376953125, -15.2490234375]
        ]]] }
      end

      its([:current_location]) do
        is_expected.to be_an_instance_of(RGeo::Cartesian::PointImpl)
      end
      its([:coverage_area]) do
        is_expected.to be_an_instance_of(RGeo::Cartesian::MultiPolygonImpl)
      end
    end
  end
end
