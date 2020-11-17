# frozen_string_literal: true

RSpec.describe V1::CarrierSerializer, type: :serializer do
  subject(:serializer) { described_class.new(object) }

  let(:object) { create(:carrier) }

  it { is_expected.to have_attributes(%i[current_location coverage_area status km_price weight_price]) }

  its(:coverage_area) { is_expected.to eql(object.coverage_area.coordinates) }
  its(:current_location) { is_expected.to eql(object.current_location.coordinates) }
end
