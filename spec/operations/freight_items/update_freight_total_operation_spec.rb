RSpec.describe FreightItems::UpdateFreightTotalOperation, type: :operation do
  subject(:operation) { described_class.new }

  describe '.call' do
    subject(:call) { operation.call(item) }
    let(:freight) { create(:freight, :with_items) }
    let(:item) { create(:freight_item, freight: freight) }

    before { item }

    context "when freight's total attributes was updated" do
      it do
        expect { call }.to change { freight.reload.cubic_meters_total }
          .to(freight.reload.items.sum(&:cubic_meters))
      end

      it do
        expect { call }.to change { freight.reload.weight_total }
          .to(freight.reload.items.sum(&:weight))
      end
    end
  end
end
