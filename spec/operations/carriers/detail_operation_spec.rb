RSpec.describe Carriers::DetailOperation, type: :operation do
  subject(:operation) { described_class.new }

  describe '.call' do
    subject(:call) { operation.call(input) }

    context 'when resource is not found' do
      let(:resource) { create(:carrier) }
      let(:input) do
        {
          id: resource.id,
          shipping_carrier_id: 0
        }
      end

      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordNotFound)
      end
    end

    context 'when resource is found' do
      let(:resource) { create(:carrier) }
      let(:input) do
        {
          id: resource.id,
          shipping_carrier_id: resource.shipping_carrier_id
        }
      end

      it { is_expected.to be_success.with(resource) }
    end
  end
end
