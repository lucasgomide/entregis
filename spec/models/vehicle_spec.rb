RSpec.describe Vehicle, type: :model do
  it { is_expected.to be_versioned }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:cubic_meters_capacity) }
  it { is_expected.to validate_presence_of(:payload_capacity) }
  it { is_expected.to belong_to(:shipment_mode) }
  it { is_expected.to have_many(:carriers).dependent(:restrict_with_exception) }

  it do
    is_expected.to validate_numericality_of(:cubic_meters_capacity)
      .is_greater_than_or_equal_to(0)
  end
end
