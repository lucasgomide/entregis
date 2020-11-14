RSpec.describe OperationFactory do
  subject(:factory) { described_class.new }

  describe '.from_controller' do
    let(:object) do
      double(
        controller_name: 'shipping_carriers',
        action_name: 'index'
      )
    end

    subject(:from_object) { factory.from_controller(object) }

    it { is_expected.to be_instance_of(ShippingCarriers::ListOperation) }
  end
end
