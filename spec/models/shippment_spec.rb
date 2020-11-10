RSpec.describe Shippment, type: :model do
  it { is_expected.to be_versioned }
  it { is_expected.to validate_presence_of(:price_cents) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to monetize(:price) }
  it { is_expected.to belong_to(:customer) }
  it { is_expected.to belong_to(:freight) }
  it { is_expected.to belong_to(:carrier) }

  it do
    is_expected.to define_enum_for(:status)
      .with_values(in_progress: 'in_progress', delivered: 'delivered', refused: 'refused')
      .backed_by_column_of_type(:string)
  end
end
