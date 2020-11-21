# frozen_string_literal: true

RSpec.describe V1::FreightItemsController, type: :controller do
  let(:detail_operation) { instance_spy(FreightItems::DetailOperation) }
  let(:destroy_operation) { instance_spy(FreightItems::DestroyOperation) }

  let(:error_factory) { instance_spy(ErrorFactory) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freight_items.detail_operation', detail_operation)
    Entregis::Container.stub('freight_items.destroy_operation', destroy_operation)
    Entregis::Container.stub('error_factory', error_factory)
  end

  describe 'GET show' do
    subject(:get_show) { get :show, params: params, format: :json }
    let(:params) { { 'id': '1', 'freight_id': '1' } }
    let(:resource) { create(:freight_item) }
    let(:serializer) { V1::FreightItemSerializer }

    before do
      allow(detail_operation).to receive(:call).and_return(result)
    end

    include_examples 'GET show resource'
  end

  describe 'DELETE destroy' do
    subject(:delete_destroy) { delete :destroy, params: params, format: :json }
    let(:params) { { 'id': '1', 'freight_id': '1' } }
    let(:resource) { create(:freight_item) }
    let(:serializer) { V1::FreightItemSerializer }

    before do
      allow(destroy_operation).to receive(:call).and_return(result)
    end

    include_examples 'DELETE destroy resource'
  end
end
