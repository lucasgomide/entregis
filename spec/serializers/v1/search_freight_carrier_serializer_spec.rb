# frozen_string_literal: true

RSpec.describe V1::SearchFreightCarrierSerializer, type: :serializer do
  subject(:serializer) { described_class.new(object).serializable_hash }

  let(:object) { create(:carrier) }

  its([:company]) { is_expected.to eql('name' => object.shipping_carrier.name) }
end
