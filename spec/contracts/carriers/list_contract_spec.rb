RSpec.describe Carriers::ListContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    context 'when the page size attribute is equal to 0' do
      let(:input) { { page: { size: 0 }, ignored: 'abc' } }

      its(:'errors.to_h') do
        is_expected.to include(page: { size: ['must be greater than 0'] })
      end
    end

    context 'when the page size attribute is greater than 100' do
      let(:input) { { page: { size: 101 }, ignored: 'abc' } }

      its(:'errors.to_h') do
        is_expected.to include(page: { size:
          ['must be less than or equal to 100'] })
      end
    end

    context 'when the shipping_carrier_id attribute is missing' do
      let(:input) { { ignored: 'abc', page: { size: 1, number: 1 } } }

      its(:'errors.to_h') { is_expected.to include(shipping_carrier_id: ['is missing']) }
    end

    context 'when the provided input is valid' do
      let(:input) do
        { ignored: 'abc', page: { size: 1, number: 1 }, shipping_carrier_id: 1 }
      end

      its(:'errors.to_h') { is_expected.to be_empty }
      its(:to_h) do
        is_expected.to eq(
          page: { size: input[:page][:size], number: input[:page][:number] },
          shipping_carrier_id: input[:shipping_carrier_id]
        )
      end
    end
  end
end
