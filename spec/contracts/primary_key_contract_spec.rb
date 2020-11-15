RSpec.describe PrimaryKeyContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    context 'when the id is missing' do
      let(:input) { {} }

      its(:'errors.to_h') { is_expected.to eql(id: ['is missing']) }
    end

    context 'when the provided input is valid' do
      let(:input) { { id: 10 } }

      its(:'errors.to_h') { is_expected.to be_empty }
      its(:to_h) { is_expected.to eq(id: 10) }
    end
  end
end
