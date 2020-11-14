RSpec.describe ErrorFactory do
  subject(:factory) { described_class.new }

  describe '.from_object' do
    subject(:from_object) { factory.from_object(object) }

    context 'when the object is an ActiveRecord::RecordInvalid' do
      let(:model) { build(:shipping_carrier, name: nil) }
      let(:object) do
        model.valid?
        ActiveRecord::RecordInvalid.new(model)
      end

      let(:expected_message) { { name: ["can't be blank"] } }

      its(:'errors.messages') { is_expected.to eql(expected_message) }
      its(:status) { is_expected.to eql(:bad_request) }

      it { is_expected.to be_an_instance_of(Error) }
    end

    context 'when the object is a Dry::Validation::Result' do
      let(:dummy_schema) do
        Class.new(Dry::Validation::Contract) do
          params do
            required(:country).value(:string)
          end
        end
      end
      let(:object) { dummy_schema.new.call({}) }
      let(:expected_message) { { country: ['is missing'] } }

      its(:'errors.messages') { is_expected.to eql(expected_message) }
      its(:status) { is_expected.to eql(:bad_request) }

      it { is_expected.to be_an_instance_of(Error) }
    end

    context 'when the object is a ActiveRecord::RecordNotFound' do
      let(:object) { ActiveRecord::RecordNotFound.new('not found x') }
      let(:expected_message) { { id: ['not found x'] } }

      its(:'errors.messages') { is_expected.to eql(expected_message) }
      its(:status) { is_expected.to eql(:not_found) }

      it { is_expected.to be_an_instance_of(Error) }
    end
  end
end
