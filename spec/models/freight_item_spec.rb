RSpec.describe FreightItem, type: :model do
  it { is_expected.to be_versioned }
  it { is_expected.to belong_to(:freight) }
  it { is_expected.to validate_presence_of(:cubic_meters) }
  it { is_expected.to validate_presence_of(:weight) }

  it do
    is_expected.to validate_numericality_of(:cubic_meters)
      .is_greater_than(0)
  end

  it do
    is_expected.to validate_numericality_of(:weight)
      .is_greater_than(0)
  end
end
