RSpec.describe Freights::FilterFactory do
  subject(:factory) { described_class.new }

  describe '.from_sort_type' do
    subject(:from_sort_type) { factory.from_sort_type(type) }

    context 'whe type is cheapest' do
      let(:type) { 'cheapest' }

      it { is_expected.to be_an_instance_of(Freights::CheapestFilter) }
    end

    context 'whe type is closest' do
      let(:type) { 'closest' }

      it { is_expected.to be_an_instance_of(Freights::ClosestFilter) }
    end
  end
end
