RSpec.describe Freights::CheapestFilter, type: :filters do
  subject(:filter) { described_class.new }
  let(:base_filter) { instance_spy(Freights::SearchBaseFilter) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freights.search_base_filter', base_filter)
  end

  describe '.call' do
    subject(:call) { filter.call(freight) }

    let(:freight) do
      create(
        :freight,
        origin: [93.97705078125, 54.09806018306312],
        destination: [93.01025390625, 54.452476553950206]
      )
    end

    let(:filter_result) { success(Carrier.all) }

    before do
      allow(base_filter).to receive(:call).and_return(filter_result)
    end

    it do
      call
      expect(base_filter).to have_received(:call).with(freight)
    end

    it { is_expected.to be_success }

    let(:coverage_area) do
      [[[
        [
          [93.92898559570312, 54.12945489870697],
          [93.94889831542969, 54.07389422020433],
          [94.1033935546875, 54.02249481009678],
          [94.16175842285156, 54.05495438499805],
          [94.1195297241211, 54.16142889682664],
          [93.92864227294922, 54.128650202989306],
          [93.92898559570312, 54.12945489870697]
        ]
      ]]]
    end

    context 'when the all carrier have the same km_price' do
      let(:carriers) do
        carrier_1
        carrier_2
        carrier_3
      end

      let(:carrier_1) do
        create(:carrier, coverage_area: coverage_area, km_price_cents: 100,
                         current_location: [
                           94.25994873046875,
                           54.13991452083357
                         ])
      end

      let(:carrier_2) do
        create(:carrier, coverage_area: coverage_area, km_price_cents: 100,
                         current_location: [
                           94.15695190429688,
                           54.12945489870697
                         ])
      end

      let(:carrier_3) do
        create(:carrier, coverage_area: coverage_area, km_price_cents: 100,
                         current_location: [
                           94.4000244140625,
                           54.16725797022493
                         ])
      end

      let(:valid_carriers) do
        [carrier_2, carrier_1, carrier_3]
      end

      before do
        carriers
      end

      it do
        expect(call.value!.map(&:id)).to eql(valid_carriers.map(&:id))
      end
    end

    context 'when the closest carrier is expensive' do
      let(:carriers) do
        carrier_1
        carrier_2
        carrier_3
      end

      let(:carrier_1) do
        create(:carrier, coverage_area: coverage_area, km_price_cents: 5000,
                         current_location: [
                           94.25994873046875,
                           54.13991452083357
                         ])
      end

      let(:carrier_2) do
        create(:carrier, coverage_area: coverage_area, km_price_cents: 9000,
                         current_location: [
                           94.15695190429688,
                           54.12945489870697
                         ])
      end

      let(:carrier_3) do
        create(:carrier, coverage_area: coverage_area, km_price_cents: 100,
                         current_location: [
                           94.4000244140625,
                           54.16725797022493
                         ])
      end

      let(:valid_carriers) do
        [carrier_3, carrier_1, carrier_2]
      end

      before do
        carriers
      end

      it do
        expect(call.value!.map(&:id)).to eql(valid_carriers.map(&:id))
      end
    end
  end
end
