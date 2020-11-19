# frozen_string_literal: true

RSpec.describe V1::FreightItemSerializer, type: :serializer do
  subject(:serializer) { described_class.new(object) }

  let(:object) { create(:freight_item) }

  it do
    is_expected.to have_attributes(%i[cubic_meters weight])
  end
end
