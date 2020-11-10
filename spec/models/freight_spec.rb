RSpec.describe Freight, type: :model do
  it { is_expected.to be_versioned }
  it { is_expected.to validate_presence_of(:origin) }
  it { is_expected.to validate_presence_of(:destination) }
  it { is_expected.to validate_presence_of(:cubic_meters_total) }
  it { is_expected.to validate_presence_of(:weight_total) }

  it do
    is_expected.to validate_numericality_of(:cubic_meters_total)
      .only_integer
      .is_greater_than(0)
  end

  it do
    is_expected.to validate_numericality_of(:weight_total)
      .only_integer
      .is_greater_than(0)
  end
end
