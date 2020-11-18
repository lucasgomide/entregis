# frozen_string_literal: true

RSpec.describe V1::CarriersController, type: :controller do
  let(:list_operation) { instance_spy(Carriers::ListOperation) }
  let(:detail_operation) { instance_spy(Carriers::DetailOperation) }
  let(:create_operation) { instance_spy(Carriers::CreateOperation) }
  let(:update_operation) { instance_spy(Carriers::UpdateOperation) }
  let(:destroy_operation) { instance_spy(Carriers::UpdateOperation) }

  let(:error_factory) { instance_spy(ErrorFactory) }

  let(:app_container_stubs) do
    Entregis::Container.stub('carriers.list_operation', list_operation)
    Entregis::Container.stub('carriers.detail_operation', detail_operation)
    Entregis::Container.stub('carriers.create_operation', create_operation)
    Entregis::Container.stub('carriers.update_operation', update_operation)
    Entregis::Container.stub('carriers.destroy_operation', destroy_operation)
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

  describe 'GET show' do
    subject(:get_show) { get :show, params: params, format: :json }
    let(:params) { { 'shipping_carrier_id': '1', 'id': resource.id.to_s } }
    let(:resource) { create(:carrier) }
    let(:serializer) { V1::CarrierSerializer }

    before do
      allow(detail_operation).to receive(:call).and_return(result)
    end

    include_examples 'GET show resource'
  end

  describe 'POST create' do
    subject(:post_create) { post :create, params: params, format: :json }
    let(:params) { { 'shipping_carrier_id': '1' } }
    let(:serializer) { V1::CarrierSerializer }
    let(:resource) { create(:carrier) }

    before do
      allow(create_operation).to receive(:call).and_return(result)
    end

    include_examples 'POST create resource'
  end

  describe 'PUT update' do
    subject(:put_update) { put :update, params: params, format: :json }
    let(:params) { { 'shipping_carrier_id': '1', 'id': '1' } }
    let(:resource) { create(:carrier) }
    let(:serializer) { V1::CarrierSerializer }

    before do
      allow(update_operation).to receive(:call).and_return(result)
    end

    include_examples 'PUT update resource'
  end

  describe 'DELETE destroy' do
    subject(:delete_destroy) { delete :destroy, params: params, format: :json }
    let(:params) { { 'id': '1', 'shipping_carrier_id': '1' } }
    let(:resource) { create(:carrier) }
    let(:serializer) { V1::CarrierSerializer }

    before do
      allow(destroy_operation).to receive(:call).and_return(result)
    end

    include_examples 'DELETE destroy resource'
  end
end
