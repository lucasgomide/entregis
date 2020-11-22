RSpec.describe BaseListContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    context 'when the page size attribute is equal to 0' do
      let(:input) { { page: { size: 0 }, ignored: 'abc' } }

      its(:'errors.to_h') do
        is_expected.to eql(page: { size: ['must be greater than 0'] })
      end
    end

    context 'when the page size attribute is greater than 100' do
      let(:input) { { page: { size: 101 }, ignored: 'abc' } }

      its(:'errors.to_h') do
        is_expected.to eql(page: { size:
          ['must be less than or equal to 100'] })
      end
    end

    context 'when the provided input is valid' do
      let(:input) { { page: { size: 100, number: 1 }, ignored: 'abc' } }

      its(:'errors.to_h') { is_expected.to be_empty }
      its(:to_h) do
        is_expected.to eq(
          page: { size: input[:page][:size], number: input[:page][:number] }
        )
      end
    end
  end
end
