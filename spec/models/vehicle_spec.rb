RSpec.describe Vehicle, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:cubic_meters_capacity) }
  it { is_expected.to validate_presence_of(:payload_capacity) }
  it { is_expected.to belong_to(:shipment_mode) }
  it do
    is_expected.to validate_numericality_of(:cubic_meters_capacity)
      .only_integer
      .is_greater_than(0)
  end
end
