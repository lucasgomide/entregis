RSpec.describe Carriers::ListOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:paginate_filter) { instance_spy(PaginateFilter) }
  let(:list_contract) { instance_spy(Carriers::ListContract) }

  let(:app_container_stubs) do
    Entregis::Container.stub('paginate_filter', paginate_filter)
    Entregis::Container.stub('carriers.list_contract', list_contract)
  end

  describe '.model' do
    subject(:model) { operation.model }
    it { is_expected.to eql(Carrier) }
  end

  describe '.call' do
    subject(:call) { operation.call(input) }

    let(:paginate_result) { success(Carrier.all) }
    let(:contract_result) { validation_contract(input: valid_input) }

    let(:input) { { ignored: 'abcs', per_page: 99, page: 1 } }
    let(:valid_input) { { per_page: 99, page: 1 } }

    before do
      allow(paginate_filter).to receive(:call).and_return(paginate_result)
      allow(list_contract).to receive(:call).and_return(contract_result)
    end

    context 'when contract validation has failed' do
      let(:contract_result) { validation_contract(success: false) }

      it { is_expected.to be_failed }
    end

    it do
      call
      expect(paginate_filter).to have_received(:call)
        .with(Carrier, input.slice(:per_page, :page))
    end

    it do
      call
      expect(list_contract).to have_received(:call).with(input)
    end

    include_examples 'testing list operation', :carrier
  end
end
