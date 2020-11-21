RSpec.describe Freights::Filters::DefaultOperation, type: :operation do
  subject(:operation) { described_class.new }

  describe '.call' do
    subject(:call) { operation.call(freight).value! }
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

    context 'when none carriers were created' do
      let(:carriers) { [] }
      it { is_expected.to be_empty }
    end

    context 'when none carriers were available' do
      let(:carriers) { create_list(:carrier, 4, :busy) }
      it { is_expected.to be_empty }
    end

    context 'when all carriers have full payload' do
      let(:carriers) { create_list(:carrier, 4, :payload_full) }
      it { is_expected.to be_empty }
    end

    context 'when all carriers have full storage' do
      let(:carriers) { create_list(:carrier, 4, :full_storage) }
      it { is_expected.to be_empty }
    end

    context 'when the origin is not coveraged' do
      let(:coverage_area) do
        [[[
          [-44.358673095703125, -18.418381607361148],
          [-44.560546875, -18.4704914579668],
          [-44.361419677734375, -18.59939520219874],
          [-44.023590087890625, -18.340187242207897],
          [-44.2364501953125, -18.241090255870276],
          [-44.358673095703125, -18.418381607361148]
        ]]]
      end
      let(:carriers) { create(:carrier, coverage_area: coverage_area, vehicle: vehicle) }
      it { is_expected.to be_empty }
    end

    context 'when the destination are is not coveraged' do
      let(:coverage_area) do
        [[[
          [-44.51934814453125, -18.327151403632488],
          [-44.322967529296875, -18.367559302479307],
          [-44.141693115234375, -18.22804696531403],
          [-44.28863525390625, -18.15107166521492],
          [-44.265289306640625, -17.956525708106838],
          [-44.549560546875, -17.9669765910837],
          [-44.872283935546875, -18.265869811558165],
          [-44.789886474609375, -18.65535335346711],
          [-44.60723876953125, -18.60720442187092],
          [-44.71160888671875, -18.192825197733164],
          [-44.51934814453125, -18.327151403632488]
        ]]]
      end
      let(:carriers) { create(:carrier, coverage_area: coverage_area, vehicle: vehicle) }
      it { is_expected.to be_empty }
    end

    context 'when any carriers match all expected filters' do
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
        valid_carriers
        create(:carrier, coverage_area: nil, vehicle: vehicle)
        create(:carrier, coverage_area: coverage_area_3, vehicle: vehicle)
      end

      let(:valid_carriers) do
        [create(:carrier, coverage_area: coverage_area_1, vehicle: vehicle),
         create(:carrier, coverage_area: coverage_area_2, vehicle: vehicle)]
      end

      it do
        expect(call.map(&:id)).to contain_exactly(*valid_carriers.map(&:id))
      end
    end
  end
end
