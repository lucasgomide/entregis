RSpec.describe ShipmentMode, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:cube_factor) }

  it { is_expected.to have_many(:vehicles) }

  it do
    is_expected.to validate_numericality_of(:cube_factor)
      .is_greater_than(0)
  end
end
