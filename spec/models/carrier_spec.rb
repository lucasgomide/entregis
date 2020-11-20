RSpec.describe Carrier, type: :model do
  it { is_expected.to be_versioned }
  it { is_expected.to belong_to(:shipping_carrier) }
  it { is_expected.to belong_to(:vehicle) }
  it { is_expected.to validate_presence_of(:current_location) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:km_price_cents) }
  it { is_expected.to validate_presence_of(:weight_price_cents) }

  it do
    is_expected.to validate_numericality_of(:available_payload)
      .is_greater_than_or_equal_to(0)
  end

  it do
    is_expected.to validate_numericality_of(:available_cubic_meters)
      .is_greater_than_or_equal_to(0)
  end

  it { is_expected.to monetize(:km_price_cents) }
  it { is_expected.to monetize(:weight_price_cents) }

  it do
    is_expected.to define_enum_for(:status)
      .with_values(available: 'available', busy: 'busy')
      .backed_by_column_of_type(:string)
  end

  context 'when the available_cubic_meters has exceeded the limit of vehicle' do
    let(:vehicle) { create(:vehicle) }

    context 'on creation' do
      subject(:model) do
        create(:carrier, vehicle: vehicle,
                         available_cubic_meters: vehicle.cubic_meters_capacity + 1)
      end

      it do
        expect { model }.to raise_error do |error|
          expect(error).to be_an_instance_of(ActiveRecord::RecordInvalid)
          expect(error.message).to eql(
            'Validation failed: Available cubic meters limit has exceeded.' \
            " It should be less than or equal to the vehicle's limit"
          )
        end
      end
    end

    context 'on updating' do
      let(:carrier) { create(:carrier, vehicle: vehicle) }

      subject(:model) do
        carrier.update!(available_cubic_meters: vehicle.cubic_meters_capacity + 1)
      end

      it do
        expect { model }.to raise_error do |error|
          expect(error).to be_an_instance_of(ActiveRecord::RecordInvalid)
          expect(error.message).to eql(
            'Validation failed: Available cubic meters limit has exceeded.' \
            " It should be less than or equal to the vehicle's limit"
          )
        end
      end
    end
  end

  context 'when the available_payload has exceeded the limit of vehicle' do
    let(:vehicle) { create(:vehicle) }

    context 'on creation' do
      subject(:model) do
        create(:carrier, vehicle: vehicle,
                         available_payload: vehicle.payload_capacity + 1)
      end

      it do
        expect { model }.to raise_error do |error|
          expect(error).to be_an_instance_of(ActiveRecord::RecordInvalid)
          expect(error.message).to eql(
            'Validation failed: Available payload limit has exceeded.' \
            " It should be less than or equal to the vehicle's limit"
          )
        end
      end
    end

    context 'on updating' do
      let(:carrier) { create(:carrier, vehicle: vehicle) }

      subject(:model) do
        carrier.update!(available_payload: vehicle.payload_capacity + 1)
      end

      it do
        expect { model }.to raise_error do |error|
          expect(error).to be_an_instance_of(ActiveRecord::RecordInvalid)
          expect(error.message).to eql(
            'Validation failed: Available payload limit has exceeded.' \
            " It should be less than or equal to the vehicle's limit"
          )
        end
      end
    end
  end
end
