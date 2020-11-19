RSpec.describe Freights::CreationContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    let(:valid_input) do
      {
        destination: [1.1, 2.0], origin: [1.2, 2.0],
        items: [{ cubic_meters: 23.0, weight: 2.0 }]
      }
    end

    context 'when the parameters are missing' do
      let(:input) { {} }

      its(:'errors.to_h') do
        is_expected.to eql(
          destination: ['is missing'], items: ['is missing'], origin: ['is missing']
        )
      end
    end

    context 'when the destination is not a valid Types::Point' do
      let(:input) { valid_input.merge(destination: [1.1]) }

      its(:'errors.to_h') do
        is_expected.to eql(destination: ['size must be 2'])
      end

      context 'when the value is not a float' do
        let(:input) { valid_input.merge(destination: [1, 3]) }

        its(:'errors.to_h') do
          is_expected.to eql(
            destination: { 0 => ['must be a float'], 1 => ['must be a float'] }
          )
        end
      end
    end

    context 'when the origin is not a valid Types::Point' do
      let(:input) { valid_input.merge(origin: [1.1]) }

      its(:'errors.to_h') do
        is_expected.to eql(origin: ['size must be 2'])
      end

      context 'when the value is not a float' do
        let(:input) { valid_input.merge(origin: [1, 3]) }

        its(:'errors.to_h') do
          is_expected.to eql(
            origin: { 0 => ['must be a float'], 1 => ['must be a float'] }
          )
        end
      end
    end

    context 'when the items is not an Array' do
      let(:input) { valid_input.merge(items: {}) }

      its(:'errors.to_h') do
        is_expected.to eql(items: ['must be an array'])
      end
    end

    context 'when the items is an empty array' do
      let(:input) { valid_input.merge(items: []) }

      its(:'errors.to_h') do
        is_expected.to eql(items: ['size cannot be less than 1'])
      end
    end

    context "when the items's value are invalid" do
      let(:input) { valid_input.merge(items: [[]]) }

      its(:'errors.to_h') do
        is_expected.to eql(
          items: { 0 => { cubic_meters: ['is missing'], weight: ['is missing'] } }
        )
      end
    end

    context 'when the input is valid' do
      let(:input) { valid_input }

      its(:'errors.to_h') { is_expected.to be_empty }
      its(:to_h) do
        is_expected.to eq(
          destination: [1.1, 2.0], origin: [1.2, 2.0],
          items: [{ cubic_meters: 23.0, weight: 2.0 }]
        )
      end
    end
  end
end
