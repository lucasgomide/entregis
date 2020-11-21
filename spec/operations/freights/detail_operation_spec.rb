RSpec.describe Freights::DetailOperation, type: :operation do
  subject(:operation) { described_class.new }

  describe '.call' do
    subject(:call) { operation.call(input) }

    context 'when resource is not found' do
      let(:input) { { id: 1 } }
      its(:to_result) do
        is_expected.to be_failed.with_instance_of(ActiveRecord::RecordNotFound)
      end
    end

    context 'when resource is found' do
      let(:resource) { create(:freight) }
      let(:input) { { id: resource.id } }

      it { is_expected.to be_success.with(resource) }
    end
  end
end
