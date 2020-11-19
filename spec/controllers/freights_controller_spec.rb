# frozen_string_literal: true

RSpec.describe V1::FreightsController, type: :controller do
  let(:create_operation) { instance_spy(Freights::CreateOperation) }

  let(:error_factory) { instance_spy(ErrorFactory) }

  let(:app_container_stubs) do
    Entregis::Container.stub('freights.create_operation', create_operation)
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
end
