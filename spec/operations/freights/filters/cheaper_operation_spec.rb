RSpec.describe Freights::Filters::CheaperOperation, type: :operation do
  subject(:operation) { described_class.new }

  describe '.call' do
    subject(:call) { operation.call(freight) }
    let(:origin) { [-44.327774047851555, -18.34279429196909] }
    let(:destination) { [-44.2790, -18.4014] }

    let(:freight) do
      create(
        :freight,
        origin: origin,
        destination: destination
      )
    end

    let(:vehicle) do
      create(
        :vehicle,
        cubic_meters_capacity: freight.cubic_meters_total * 2,
        payload_capacity: freight.weight_total * 2
      )
    end

    before { carriers }

    include_examples 'testing default list filter'

    let(:coverage_area_1) do
      [[[
        [-44.35798645019531, -18.324218204529696],
        [-44.29893493652344, -18.45974509543414],
        [-44.219627380371094, -18.38091789856933],
        [-44.29618835449219, -18.314766446928143],
        [-44.35798645019531, -18.324218204529696]
      ]]]
    end

    let(:coverage_area_2) do
      [[[
        [-44.33326721191406, -18.305640122258644],
        [-44.344940185546875, -18.391669187688752],
        [-44.25464630126953, -18.420661743842945],
        [-44.247779846191406, -18.306292018544276],
        [-44.33326721191406, -18.305640122258644]
      ]]]
    end

    let(:coverage_area_3) do
      [[[
        [-44.468536376953125, -18.345075428248094],
        [-44.436607360839844, -18.415124217111945],
        [-44.463043212890625, -18.318025732001438],
        [-44.468536376953125, -18.345075428248094]
      ]]]
    end

    let(:carriers) do
      carrier_1
      carrier_3
      carrier_2
      create(:carrier, coverage_area: nil, vehicle: vehicle)
      create(:carrier, coverage_area: coverage_area_3, vehicle: vehicle)
    end

    let(:carrier_1) do
      create(
        :carrier, coverage_area: coverage_area_2, vehicle: vehicle,
        km_price_cents: 1500
      )
    end

    let(:carrier_2) do
      create(
        :carrier, coverage_area: coverage_area_1, vehicle: vehicle,
        km_price_cents: 1000
      )
    end

    let(:carrier_3) do
      create(
        :carrier, coverage_area: coverage_area_2, vehicle: vehicle,
        km_price_cents: 500
      )
    end

    let(:valid_carriers) do
      [carrier_3, carrier_2, carrier_1]
    end

    it do
      expect(call.map(&:id)).to eql(valid_carriers.map(&:id))
    end
  end
end
