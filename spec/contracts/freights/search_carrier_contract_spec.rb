RSpec.describe Freights::SearchCarrierContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    let(:valid_input) do
      {
        id: 1, sort: 'closest', page: 1, per_page: 10
      }
    end

    context 'when the parameters are missing' do
      let(:input) { {} }

      its(:'errors.to_h') do
        is_expected.to eql(id: ['is missing'], sort: ['is missing'])
      end
    end

    context 'when the sort parameter is not a string' do
      let(:input) { valid_input.merge(sort: 123) }

      its(:'errors.to_h') do
        is_expected.to eql(sort: ['must be a string'])
      end
    end

    context 'when the sort parameter is invalid' do
      let(:input) { valid_input.merge(sort: 'abc') }

      its(:'errors.to_h') do
        is_expected.to eql(sort: ['must be one of: closest, cheapest'])
      end
    end

    context 'when the per_page attribute is equal to 0' do
      let(:input) { valid_input.merge(per_page: 0) }

      its(:'errors.to_h') { is_expected.to eq(per_page: ['must be greater than 0']) }
    end

    context 'when the per_page attribute is greater than 10' do
      let(:input) { valid_input.merge(per_page: 11) }

      its(:'errors.to_h') do
        is_expected.to include(per_page:
          ['must be less than or equal to 10'])
      end
    end

    context 'when the input is valid' do
      let(:input) { valid_input }

      its(:'errors.to_h') { is_expected.to be_empty }
      its(:to_h) do
        is_expected.to eq(id: 1, sort: 'closest', page: 1, per_page: 10)
      end
    end
  end
end
