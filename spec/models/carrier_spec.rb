RSpec.describe Carrier, type: :model do
  it { is_expected.to be_versioned }
  it { is_expected.to belong_to(:shipping_carrier) }
  it { is_expected.to belong_to(:vehicle) }
  it { is_expected.to validate_presence_of(:current_location) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:km_price_cents) }
  it { is_expected.to validate_presence_of(:weight_price_cents) }
  it { is_expected.to validate_presence_of(:available_cubic_meters) }
  it { is_expected.to validate_presence_of(:available_payload) }

  it { is_expected.to monetize(:km_price_cents) }
  it { is_expected.to monetize(:weight_price_cents) }

  it do
    is_expected.to define_enum_for(:status)
      .with_values(available: 'available', busy: 'busy')
      .backed_by_column_of_type(:string)
  end
end
