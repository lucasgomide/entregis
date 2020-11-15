RSpec.shared_examples 'testing list operation' do |factory_bot_model|
  context 'when none results were found' do
    its(:success) { is_expected.to be_empty }
  end

  context 'when any results were found' do
    let(:objects) { create_list(factory_bot_model, 3) }
    before { objects }

    its(:'success.count') { is_expected.to eql(objects.count) }
  end
end
