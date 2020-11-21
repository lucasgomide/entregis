RSpec.describe Freights::SearchCarriersOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:filter_factory) { instance_spy(Freights::FilterFactory) }
  let(:search_carrier_contract) { instance_spy(Freights::SearchCarrierContract) }
  let(:paginate_filter) { instance_spy(PaginateFilter) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freights.filter_factory', filter_factory)
    Entregis::Container.stub('freights.search_carrier_contract', search_carrier_contract)
    Entregis::Container.stub('paginate_filter', paginate_filter)
  end

  describe '.call' do
    subject(:call) { operation.call(input) }
    let(:freight) { create(:freight) }
    let(:input) do
      {
        id: freight.id,
        sort: 'sort-method',
        page: 1,
        per_page: 10
      }
    end

    let(:valid_input) { input }
    let(:factory) { instance_spy(Freights::CheapestFilter) }

    let(:carriers) { create_list(:carrier, 2) }

    let(:contract_result) { validation_contract(input: valid_input) }
    let(:filter_result) { success(carriers) }
    let(:paginate_result) { success(carriers.take(1)) }

    before do
      allow(search_carrier_contract).to receive(:call).and_return(contract_result)
      allow(filter_factory).to receive(:from_sort_type).and_return(factory)
      allow(factory).to receive(:call).and_return(filter_result)
      allow(paginate_filter).to receive(:call).and_return(paginate_result)
    end

    it do
      call
      expect(search_carrier_contract).to have_received(:call).with(input)
    end

    it do
      call
      expect(filter_factory).to have_received(:from_sort_type)
        .with(contract_result.to_h[:sort])
    end

    it do
      call
      expect(factory).to have_received(:call)
        .with(an_instance_of(Freight))
    end

    it do
      call
      expect(paginate_filter).to have_received(:call)
        .with(filter_result.value!, input.slice(:page, :per_page))
    end

    context 'when contract validation has failed' do
      let(:contract_result) { validation_contract(success: false) }

      it { is_expected.to be_failed.with_instance_of(Dry::Validation::Result) }
    end

    context 'when resource is not found' do
      let(:valid_input) do
        input.merge(id: 0)
      end

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the filter returns an error' do
      let(:filter_result) { failure('any error on filter') }

      its(:to_result) do
        is_expected.to be_failed.with('any error on filter')
      end
    end

    context 'when the pagination returns an error' do
      let(:paginate_result) { failure('any error on pagination') }

      its(:to_result) do
        is_expected.to be_failed.with('any error on pagination')
      end
    end

    context 'when the proccess has been completed' do
      subject(:result) { call.value! }

      context 'when none result was found' do
        let(:paginate_result) { success([]) }

        it { is_expected.to be_empty }
      end

      context 'when result is not empty' do
        let(:paginate_result) { success(carriers) }

        it { is_expected.to eql(paginate_result.value!) }
      end
    end
  end
end
