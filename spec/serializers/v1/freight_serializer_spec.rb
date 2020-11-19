# frozen_string_literal: true

RSpec.describe V1::FreightSerializer, type: :serializer do
  subject(:serializer) { described_class.new(object) }

  let(:object) { create(:freight) }

  it do
    is_expected.to have_attributes(
      %i[origin destination cubic_meters_total weight_total]
    )
  end

  it { is_expected.to have_many(:items) }

  its(:origin) { is_expected.to eql(object.origin.coordinates) }
  its(:destination) { is_expected.to eql(object.destination.coordinates) }
end
