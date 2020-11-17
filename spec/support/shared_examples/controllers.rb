RSpec.shared_examples 'PUT update resource' do
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

RSpec.shared_examples 'GET show resource' do
  context 'rendered with successful' do
    let(:result) { success(resource) }

    it { is_expected.to have_http_status(:ok) }

    it do
      is_expected.to serialize_object(resource)
        .with(serializer)
        .including(['carriers'])
    end

    it do
      get_show
      expect(detail_operation).to have_received(:call).with(params)
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
      is_expected.to serialize_object(error)
        .with(ActiveModel::Serializer::ErrorSerializer)
    end

    it { is_expected.to have_http_status(:not_found) }
  end
end

RSpec.shared_examples 'GET index resources' do
  context 'rendered with successful' do
    let(:result) { success(resources) }

    it { is_expected.to have_http_status(:ok) }

    it do
      is_expected.to serialize_object(resources)
        .with_array_of(serializer)
    end

    it do
      get_index
      expect(list_operation).to have_received(:call).with(params)
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

RSpec.shared_examples 'POST create resource' do
  context 'rendered with successful' do
    let(:result) { success(resource) }

    it { is_expected.to have_http_status(:created) }

    it do
      is_expected.to serialize_object(resource).with(serializer)
    end

    it do
      subject
      expect(create_operation).to have_received(:call).with(params)
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

RSpec.shared_examples 'DELETE destroy resource' do
  context 'rendered with successful' do
    let(:result) { success(resource) }

    it { is_expected.to have_http_status(:ok) }

    it do
      is_expected.to serialize_object(resource).with(serializer)
    end

    it do
      subject
      expect(destroy_operation).to have_received(:call).with(params)
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
