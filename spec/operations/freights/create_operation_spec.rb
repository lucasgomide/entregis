RSpec.describe Freights::CreateOperation, type: :operation do
  subject(:operation) { described_class.new }
  let(:creation_contract) { instance_spy(Freights::CreationContract) }
  let(:creation_builder) { instance_spy(Freights::CreationBuilder) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freights.creation_contract', creation_contract)
    Entregis::Container.stub('freights.creation_builder', creation_builder)
  end

  describe '.call' do
    subject(:call) { operation.call(input) }
    let(:vehicle) { create(:vehicle) }
    let(:shipping_carrier) { create(:shipping_carrier) }

    let(:input) do
      {
        origin: [1.2, 1.1],
        destination: [1.1, 2.2],
        items: [
          { cubic_meters: 1.0, weight: 2.0 },
          { cubic_meters: 82.4, weight: 29.2 }
        ]
      }
    end

    let(:valid_input) { input }

    let(:contract_result) { validation_contract(input: valid_input) }
    let(:build_result) do
      success(
        valid_input.merge(
          origin: coordiantes_to_wkt(valid_input[:origin]),
          destination: coordiantes_to_wkt(valid_input[:destination])
        )
      )
    end

    before do
      allow(creation_contract).to receive(:call).and_return(contract_result)
      allow(creation_builder).to receive(:build_attributes).and_return(build_result)
    end

    it do
      call
      expect(creation_contract).to have_received(:call).with(input)
    end

    it do
      call
      aggregate_failures do
        expect(creation_builder).to have_received(:from_params).with(contract_result.to_h)
        expect(creation_builder).to have_received(:build_attributes)
      end
    end

    context 'when contract validation has failed' do
      let(:contract_result) { validation_contract(success: false) }

      it { is_expected.to be_failed.with_instance_of(Dry::Validation::Result) }
    end

    context 'when builder has failed' do
      let(:error) { 'any error' }
      let(:build_result) { failure(error) }

      it { is_expected.to be_failed.with(error) }
    end

    context 'when resource creation has failed' do
      let(:valid_input) do
        input.merge(items: [])
      end

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordInvalid)
      end
    end

    context 'when resource was successful created' do
      subject(:result) { call.to_result.value! }
      let(:cm_total) { input[:items].sum { |i| i[:cubic_meters] } }
      let(:weight_total) { input[:items].sum { |i| i[:weight] } }

      it { is_expected.to be_an_instance_of(Freight) }

      its('origin.coordinates') { is_expected.to eq(input[:origin]) }
      its('destination.coordinates') { is_expected.to eq(input[:destination]) }
      its(:cubic_meters_total) { is_expected.to eq(cm_total) }
      its(:weight_total) { is_expected.to eq(weight_total) }

      it do
        aggregate_failures do
          result.items.each_with_index do |item, key|
            expect(item.cubic_meters).to eql(input[:items][key][:cubic_meters])
            expect(item.weight).to eql(input[:items][key][:weight])
          end
        end
      end

      it do
        expect { result }.to change { Freight.count }.by(1)
      end

      it do
        expect { result }.to change { FreightItem.count }.by(input[:items].size)
      end
    end
  end
end
