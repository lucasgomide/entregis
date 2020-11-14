# frozen_string_literal: true

RSpec.describe V1::ShippingCarrierSerializer, type: :serializer do
  subject(:serializer) { described_class.new(object) }

  let(:object) { create(:shipping_carrier) }

  it { is_expected.to have_attributes(%i[name document]) }
end
