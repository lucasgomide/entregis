RSpec.describe ShippingCarriers::ListOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:paginate_filter) { instance_spy(PaginateFilter) }
  let(:base_list_contract) { instance_spy(BaseListContract) }

  let(:app_container_stubs) do
    Entregis::Container.stub('paginate_filter', paginate_filter)
    Entregis::Container.stub('base_list_contract', base_list_contract)
  end

  describe '.model' do
    subject(:model) { operation.model }

    its(:klass) { is_expected.to eq(ShippingCarrier) }
    its(:includes_values) { is_expected.to eql([:carriers]) }
  end

  describe '.call' do
    subject(:call) { operation.call(input) }

    let(:paginate_result) { success(ShippingCarrier.all) }
    let(:contract_result) { validation_contract(input: valid_input) }

    let(:input) { { ignored: 'abcs', page: { size: 99, number: 1 } } }
    let(:valid_input) { { page: { size: 99, number: 1 } } }

    before do
      allow(paginate_filter).to receive(:call).and_return(paginate_result)
      allow(base_list_contract).to receive(:call).and_return(contract_result)
    end

    context 'when contract validation has failed' do
      let(:contract_result) { validation_contract(success: false) }

      it { is_expected.to be_failed }
    end

    it do
      call
      expect(paginate_filter).to have_received(:call)
        .with(ShippingCarrier.includes(:carriers), input.slice(:page))
    end

    it do
      call
      expect(base_list_contract).to have_received(:call).with(input)
    end

    include_examples 'testing list operation', :shipping_carrier
  end
end
