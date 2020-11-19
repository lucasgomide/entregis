RSpec.describe Freights::CreationBuilder, type: :builder do
  subject(:builder) { described_class.new }

  describe '.build_attributes' do
    subject(:build_attributes) { builder.from_params(input).build_attributes }

    context 'when the process to convert coordinates to RGeo Point has successful' do
      subject(:success) { build_attributes.value! }
      let(:input) { { origin: [1, 3], destination: [2, 3] } }

      its([:origin]) { is_expected.to be_an_instance_of(RGeo::Cartesian::PointImpl) }
      its([:destination]) { is_expected.to be_an_instance_of(RGeo::Cartesian::PointImpl) }
    end
  end
end
