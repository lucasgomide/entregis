RSpec.describe ShippingCarrier, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:document) }

  it { is_expected.to have_many(:carriers) }
end
