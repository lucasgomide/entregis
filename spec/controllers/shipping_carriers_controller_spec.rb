# frozen_string_literal: true

RSpec.describe V1::ShippingCarriersController, type: :controller do
  let(:list) { instance_spy(ShippingCarriers::ListOperation) }
  let(:detail) { instance_spy(ShippingCarriers::DetailOperation) }
  let(:update_operation) { instance_spy(ShippingCarriers::UpdateOperation) }

  let(:error_factory) { instance_spy(ErrorFactory) }

  let(:app_container_stubs) do
    Entregis::Container.stub('shipping_carriers.list_operation', list)
    Entregis::Container.stub('shipping_carriers.detail_operation', detail)
    Entregis::Container.stub('shipping_carriers.update_operation', update_operation)
    Entregis::Container.stub('error_factory', error_factory)
  end

  describe 'GET index' do
    subject(:get_index) { get :index, params: params, format: :json }
    let(:params) { {} }

    before do
      allow(list).to receive(:call).and_return(result)
    end

    context 'rendered with successful' do
      let(:result) { success(shipping_carriers) }
      let(:shipping_carriers) { create_list(:shipping_carrier, 5) }

      it { is_expected.to have_http_status(:ok) }

      it do
        is_expected.to serialize_object(shipping_carriers)
          .with_array_of(V1::ShippingCarrierSerializer)
      end

      it do
        get_index
        expect(list).to have_received(:call).with(params)
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

  describe 'GET show' do
    subject(:get_show) { get :show, params: params, format: :json }
    let(:params) { { 'id': resource.id.to_s } }
    let(:resource) { create(:shipping_carrier) }

    before do
      allow(detail).to receive(:call).and_return(result)
    end

    context 'rendered with successful' do
      let(:result) { success(resource) }

      it { is_expected.to have_http_status(:ok) }

      it do
        is_expected.to serialize_object(resource)
          .with(V1::ShippingCarrierSerializer)
      end

      it do
        get_show
        expect(detail).to have_received(:call).with(params)
      end
    end

    context 'rendered with error' do
      let(:result) { failure('error') }
      let(:error) do
        Error.new(status: :not_found, errors: { messages: { key: ['error'] } })
      end

      before do
        allow(error_factory).to receive(:from_object).and_return(error)
      end

      it do
        is_expected.to serialize_object(error).with(
          ActiveModel::Serializer::ErrorSerializer
        )
      end

      it { is_expected.to have_http_status(:not_found) }
    end
  end

  describe 'PUT update' do
    subject(:put_update) { put :update, params: params, format: :json }
    let(:params) { { 'id': resource.id.to_s } }
    let(:resource) { create(:shipping_carrier) }
    let(:serializer) { V1::ShippingCarrierSerializer }

    before do
      allow(update_operation).to receive(:call).and_return(result)
    end

    context 'rendered with successful' do
      let(:result) { success(resource) }

      it { is_expected.to have_http_status(:ok) }

      it do
        is_expected.to serialize_object(resource).with(serializer)
      end

      it do
        subject
        expect(update_operation).to have_received(:call).with(params)
      end
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
end
