RSpec.describe ShippingCarriers::UpdatingContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    let(:valid_input) do
      {
        id: 1,
        name: 'James',
        document: '532.820.857-96'
      }
    end

    context 'when the id is missing' do
      let(:input) { {} }

      its(:'errors.to_h') { is_expected.to eql(id: ['is missing']) }
    end

    include_examples 'testing document'
  end
end
