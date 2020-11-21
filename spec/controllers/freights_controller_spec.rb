# frozen_string_literal: true

RSpec.describe V1::FreightsController, type: :controller do
  let(:create_operation) { instance_spy(Freights::CreateOperation) }
  let(:search_carriers_operation) { instance_spy(Freights::SearchCarriersOperation) }
  let(:destroy_operation) { instance_spy(Freights::DestroyOperation) }

  let(:error_factory) { instance_spy(ErrorFactory) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freights.create_operation', create_operation)
    Entregis::Container.stub('freights.search_carriers_operation',
                             search_carriers_operation)
    Entregis::Container.stub('freights.destroy_operation', destroy_operation)
    Entregis::Container.stub('error_factory', error_factory)
  end

  describe 'POST create' do
    subject(:post_create) { post :create, params: params, format: :json }
    let(:params) { { 'shipping_carrier_id': '1' } }
    let(:serializer) { V1::FreightSerializer }
    let(:resource) { create(:freight) }

    before do
      allow(create_operation).to receive(:call).and_return(result)
    end

    include_examples 'POST create resource'
  end

  describe 'GET search_carriers' do
    subject(:get_search_carriers) { get :search_carriers, params: params, format: :json }
    let(:params) { { 'id': '1' } }
    let(:serializer) { V1::SearchFreightCarrierSerializer }
    let(:resources) { create_list(:carrier, 2) }

    before do
      allow(search_carriers_operation).to receive(:call).and_return(result)
    end

    context 'rendered with successful' do
      let(:result) { success(resources) }

      it { is_expected.to have_http_status(:ok) }

      it do
        is_expected.to serialize_object(resources)
          .with_array_of(serializer)
      end

      it do
        get_search_carriers
        expect(search_carriers_operation).to have_received(:call).with(params)
      end

      pending('testing links into response')
      pending("testing available_filters into response's meta")
    end

    context 'rendered with error' do
      let(:result) { failure('error') }
      let(:error) do
        Error.new(status: :bad_request, errors: { messages: { key: ['error'] } })
      end

      before do
        allow(error_factory).to receive(:from_object).and_return(error)
      end

      it do
        is_expected.to serialize_object(error)
          .with(ActiveModel::Serializer::ErrorSerializer)
      end

      it { is_expected.to have_http_status(:bad_request) }
    end
  end

  describe 'DELETE destroy' do
    subject(:delete_destroy) { delete :destroy, params: params, format: :json }
    let(:params) { { 'id': '1' } }
    let(:resource) { create(:freight) }
    let(:serializer) { V1::FreightSerializer }

    before do
      allow(destroy_operation).to receive(:call).and_return(result)
    end

    include_examples 'DELETE destroy resource'
  end
end
