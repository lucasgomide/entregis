RSpec.describe Carriers::UpdatingContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    context 'when the id is missing' do
      let(:input) { {} }

      its(:'errors.to_h') { is_expected.to eql(id: ['is missing']) }
    end

    context 'when the provided input is valid' do
      let(:input) { { id: 10, status: 'busy', ignored: true } }

      its(:'errors.to_h') { is_expected.to be_empty }
      its(:to_h) { is_expected.to eq(id: 10, status: 'busy') }
    end
  end
end
