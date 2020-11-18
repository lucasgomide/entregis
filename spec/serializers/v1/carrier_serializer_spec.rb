# frozen_string_literal: true

RSpec.describe V1::CarrierSerializer, type: :serializer do
  subject(:serializer) { described_class.new(object) }

  let(:object) { create(:carrier) }

  it do
    is_expected.to have_attributes(
      %i[current_location coverage_area status km_price weight_price]
    )
  end

  its(:coverage_area) { is_expected.to eql(object.coverage_area.coordinates) }

  context 'when coverage_area is not present' do
    let(:object) { create(:carrier, coverage_area: nil) }
    its(:coverage_area) { is_expected.to be_nil }
  end

  its(:current_location) { is_expected.to eql(object.current_location.coordinates) }
end
