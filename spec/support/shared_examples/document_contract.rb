RSpec.shared_examples 'testing document' do |_factory_bot_model|
  context 'when the document is invalid' do
    context 'when the document size is less than 11' do
      let(:input) { valid_input.merge(document: 'acb1234567') }

      its(:'errors.to_h') do
        is_expected.to eql(document: ['size cannot be less than 11'])
      end
    end

    context 'when the document size is greater than 18' do
      let(:input) do
        valid_input.merge(document: 'acb123456712camd.1/')
      end

      its(:'errors.to_h') do
        is_expected.to eql(document: ['size cannot be greater than 18'])
      end
    end

    context 'when CPF is invalid' do
      let(:input) { valid_input.merge(document: '532.820.852-96') }

      its(:'errors.to_h') { is_expected.to eql(document: ['is invalid']) }
    end

    context 'when CNPJ is invalid' do
      let(:input) { valid_input.merge(document: '53.195.254/0003-79') }

      its(:'errors.to_h') { is_expected.to eql(document: ['is invalid']) }
    end
  end

  context 'when the CNPJ is valid' do
    let(:input) { valid_input.merge(document: '53.195.254/0001-79') }

    its(:'errors.to_h') { is_expected.to be_empty }
    its(:to_h) { is_expected.to eq(valid_input.merge(document: '53195254000179')) }
  end

  context 'when the CPF is valid' do
    let(:input) { valid_input }

    its(:'errors.to_h') { is_expected.to be_empty }
    its(:to_h) { is_expected.to eq(valid_input.merge(document: '53282085796')) }
  end
end
