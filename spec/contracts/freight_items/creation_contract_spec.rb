RSpec.describe FreightItems::CreationContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    let(:valid_input) do
      { cubic_meters: 10.0, weight: 1.0, freight_id: 1, ignored: true }
    end

    context 'when the id is missing' do
      let(:input) { {} }

      its(:'errors.to_h') do
        is_expected.to eql(cubic_meters: ['is missing'], weight: ['is missing'],
                           freight_id: ['is missing'])
      end
    end

    context 'when the cubic_meters is not float' do
      let(:input) { valid_input.merge(cubic_meters: 'abc') }

      its(:'errors.to_h') do
        is_expected.to eql(cubic_meters: ['must be a float'])
      end
    end

    context 'when the cubic_meters is not greater than 0' do
      let(:input) { valid_input.merge(cubic_meters: 0.0) }

      its(:'errors.to_h') do
        is_expected.to eql(cubic_meters: ['must be greater than 0'])
      end
    end

    context 'when the cubic_meters is not float' do
      let(:input) { valid_input.merge(weight: 'abc') }

      its(:'errors.to_h') do
        is_expected.to eql(weight: ['must be a float'])
      end
    end

    context 'when the weight is not greater than 0' do
      let(:input) { valid_input.merge(weight: 0.0) }

      its(:'errors.to_h') do
        is_expected.to eql(weight: ['must be greater than 0'])
      end
    end

    context 'when the freight_id is not an integer' do
      let(:input) { valid_input.merge(freight_id: 'abc') }

      its(:'errors.to_h') do
        is_expected.to eql(freight_id: ['must be an integer'])
      end
    end

    context 'when the provided input is valid' do
      let(:input) { valid_input }

      its(:'errors.to_h') { is_expected.to be_empty }
      its(:to_h) { is_expected.to eq(cubic_meters: 10, weight: 1, freight_id: 1) }
    end
  end
end
