RSpec.describe Carriers::ListContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    context 'when the per_page attribute is equal to 0' do
      let(:input) { { per_page: 0, ignored: 'abc' } }

      its(:'errors.to_h') { is_expected.to include(per_page: ['must be greater than 0']) }
    end

    context 'when the per_page attribute is greater than 100' do
      let(:input) { { per_page: 101, ignored: 'abc' } }

      its(:'errors.to_h') do
        is_expected.to include(per_page:
          ['must be less than or equal to 100'])
      end
    end

    context 'when the shipping_carrier_id attribute is missing' do
      let(:input) { { per_page: 10, ignored: 'abc', page: 10 } }

      its(:'errors.to_h') { is_expected.to include(shipping_carrier_id: ['is missing']) }
    end

    context 'when the provided input is valid' do
      let(:input) { { per_page: 10, ignored: 'abc', page: 10, shipping_carrier_id: 1 } }

      its(:'errors.to_h') { is_expected.to be_empty }
      its(:to_h) do
        is_expected.to eq(
          per_page: input[:per_page], page: input[:page],
          shipping_carrier_id: input[:shipping_carrier_id]
        )
      end
    end
  end
end
