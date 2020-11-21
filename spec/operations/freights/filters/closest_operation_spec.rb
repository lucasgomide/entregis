RSpec.describe Freights::Filters::ClosestOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:default_operation) { instance_spy(Freights::Filters::DefaultOperation) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freights.filters.default_operation', default_operation)
  end

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

    let(:filter_result) { success(Carrier.all) }

    before do
      carriers
      allow(default_operation).to receive(:call).and_return(filter_result)
    end

    let(:carriers) do
      carrier_1
      carrier_3
      carrier_2
    end

    let(:carrier_1) do
      create(
        :carrier, current_location: [-44.31404113769531, -18.33334354949917]
      )
    end

    let(:carrier_2) do
      create(
        :carrier, current_location: [-44.261856079101555, -18.366907637185466]
      )
    end

    let(:carrier_3) do
      create(
        :carrier, current_location: [-44.314727783203125, -18.388085499159203]
      )
    end

    let(:valid_carriers) do
      [carrier_1, carrier_3, carrier_2]
    end

    it do
      call
      expect(default_operation).to have_received(:call).with(freight)
    end

    it { is_expected.to be_success }

    it do
      expect(call.value!.map(&:id)).to eql(valid_carriers.map(&:id))
    end
  end
end
