RSpec.describe Freights::CheapestFilter, type: :filters do
  subject(:filter) { described_class.new }
  let(:base_filter) { instance_spy(Freights::SearchBaseFilter) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freights.search_base_filter', base_filter)
  end

  describe '.call' do
    subject(:call) { filter.call(freight) }
    let(:origin) { [-44.327774047851555, -18.34279429196909] }
    let(:destination) { [-44.2790, -18.4014] }

    let(:freight) do
      create(
        :freight,
        origin: origin,
        destination: destination
      )
    end

    let(:filter_result) { success(Carrier.all) }

    before do
      carriers
      allow(base_filter).to receive(:call).and_return(filter_result)
    end

    let(:carriers) do
      carrier_1
      carrier_3
      carrier_2
    end

    let(:carrier_1) { create(:carrier, km_price_cents: 1500) }

    let(:carrier_2) { create(:carrier, km_price_cents: 1000) }

    let(:carrier_3) { create(:carrier, km_price_cents: 500) }

    let(:valid_carriers) do
      [carrier_3, carrier_2, carrier_1]
    end

    it do
      call
      expect(base_filter).to have_received(:call).with(freight)
    end

    it { is_expected.to be_success }
    it do
      expect(call.value!.map(&:id)).to eql(valid_carriers.map(&:id))
    end
  end
end
