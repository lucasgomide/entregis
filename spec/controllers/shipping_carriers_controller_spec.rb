# frozen_string_literal: true

RSpec.describe V1::ShippingCarriersController, type: :controller do
  let(:list_operation) { instance_spy(ShippingCarriers::ListOperation) }
  let(:detail_operation) { instance_spy(ShippingCarriers::DetailOperation) }
  let(:update_operation) { instance_spy(ShippingCarriers::UpdateOperation) }

  let(:error_factory) { instance_spy(ErrorFactory) }

  let(:app_container_stubs) do
    Entregis::Container.stub('shipping_carriers.list_operation', list_operation)
    Entregis::Container.stub('shipping_carriers.detail_operation', detail_operation)
    Entregis::Container.stub('shipping_carriers.update_operation', update_operation)
    Entregis::Container.stub('error_factory', error_factory)
  end

  describe 'GET index' do
    subject(:get_index) { get :index, params: params, format: :json }
    let(:params) { {} }
    let(:resources) { create_list(:shipping_carrier, 5) }
    let(:serializer) { V1::ShippingCarrierSerializer }

    before do
      allow(list_operation).to receive(:call).and_return(result)
    end

    include_examples 'GET index resources'
  end

  describe 'GET show' do
    subject(:get_show) { get :show, params: params, format: :json }
    let(:params) { { 'id': resource.id.to_s } }
    let(:resource) { create(:shipping_carrier) }
    let(:serializer) { V1::ShippingCarrierSerializer }

    before do
      allow(detail_operation).to receive(:call).and_return(result)
    end

    include_examples 'GET show resource'
  end

  describe 'PUT update' do
    subject(:put_update) { put :update, params: params, format: :json }
    let(:params) { { 'id': resource.id.to_s } }
    let(:resource) { create(:shipping_carrier) }
    let(:serializer) { V1::ShippingCarrierSerializer }

    before do
      allow(update_operation).to receive(:call).and_return(result)
    end

    include_examples 'PUT update resource'
  end
end
