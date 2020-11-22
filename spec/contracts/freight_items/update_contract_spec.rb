RSpec.describe FreightItems::UpdatingContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    context 'when the id is missing' do
      let(:input) { {} }

      its(:'errors.to_h') do
        is_expected.to eql(id: ['is missing'], freight_id: ['is missing'])
      end
    end

    context 'when the provided input is valid' do
      let(:input) do
        { id: 10, freight_id: 1, weight: 12,
          cubic_meters: 232, ignored: true }
      end

      its(:'errors.to_h') { is_expected.to be_empty }
      its(:to_h) do
        is_expected.to eq(id: 10, freight_id: 1, weight: 12,
                          cubic_meters: 232)
      end
    end
  end
end
