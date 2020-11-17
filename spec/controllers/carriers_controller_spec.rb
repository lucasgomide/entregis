# frozen_string_literal: true

RSpec.describe V1::CarriersController, type: :controller do
  let(:list_operation) { instance_spy(Carriers::ListOperation) }

  let(:error_factory) { instance_spy(ErrorFactory) }

  let(:app_container_stubs) do
    Entregis::Container.stub('carriers.list_operation', list_operation)
    Entregis::Container.stub('error_factory', error_factory)
  end

  describe 'GET index' do
    subject(:get_index) { get :index, params: params, format: :json }
    let(:params) { { 'shipping_carrier_id': '1' } }
    let(:resources) { create_list(:carrier, 5) }
    let(:serializer) { V1::CarrierSerializer }

    before do
      allow(list_operation).to receive(:call).and_return(result)
    end

    include_examples 'GET index resources'
  end
end
