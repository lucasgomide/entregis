RSpec.describe PaginateFilter, type: :filters do
  subject(:filter) { described_class.new }

  describe '.call' do
    subject(:call) { filter.call(ShippingCarrier, input) }

    context 'paginate with default attributes' do
      let(:input) { {} }
      its(:'success.limit_value') { is_expected.to eql(PaginateFilter::DEFAULT_PAGE_SIZE) }
      its(:'success.current_page') { is_expected.to eql(PaginateFilter::DEFAULT_PAGE) }
    end

    context 'paginate with provided attributes' do
      let(:input) { { per_page: 1, page: 3 } }
      its(:'success.limit_value') { is_expected.to eql(input[:per_page]) }
      its(:'success.current_page') { is_expected.to eql(input[:page]) }
    end
  end
end
