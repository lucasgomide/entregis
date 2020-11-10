RSpec.describe FreightItem, type: :model do
  it { is_expected.to belong_to(:freight) }
  it { is_expected.to validate_presence_of(:cubic_meters) }
  it { is_expected.to validate_presence_of(:weight) }
  it do
    is_expected.to validate_numericality_of(:cubic_meters)
      .only_integer
      .is_greater_than(0)
  end
  it do
    is_expected.to validate_numericality_of(:weight)
      .only_integer
      .is_greater_than(0)
  end
end
