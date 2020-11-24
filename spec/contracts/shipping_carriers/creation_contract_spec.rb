RSpec.describe ShippingCarriers::CreationContract, type: :contract do
  subject(:contract) { described_class.new }

  describe '.call' do
    subject(:call) { contract.call(input) }
    let(:valid_input) do
      {
        name: 'James',
        document: '532.820.857-96'
      }
    end

    context 'when the id is missing' do
      let(:input) { {} }

      its(:'errors.to_h') do
        is_expected.to eql(name: ['is missing'], document: ['is missing'])
      end
    end

    include_examples 'testing document'
  end
end
