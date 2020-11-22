RSpec.describe PaginateFilter, type: :filters do
  subject(:filter) { described_class.new }

  describe '.call' do
    subject(:call) { filter.call(ShippingCarrier, input) }

    context 'paginate with default attributes' do
      let(:input) { {} }
      its(:'success.limit_value') do
        is_expected.to eql(PaginateFilter::DEFAULT_PAGE_SIZE)
      end
      its(:'success.current_page') do
        is_expected.to eql(PaginateFilter::DEFAULT_PAGE)
      end
    end

    context 'paginate with provided attributes' do
      let(:input) { { page: { size: 1, number: 3 } } }
      its(:'success.limit_value') { is_expected.to eql(input[:page][:size]) }
      its(:'success.current_page') { is_expected.to eql(input[:page][:number]) }
    end
  end
end
