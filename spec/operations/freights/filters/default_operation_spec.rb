RSpec.describe Freights::Filters::DefaultOperation, type: :operation do
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
  end
end
