module ShippingCarriers
  class DocumentContract < ApplicationContract
    register_macro(:valid_document?) do
      if values[:document].present?
        cpf = CPF.new(value)
        cnpj = CNPJ.new(value)

        document = (cnpj.valid? && cnpj.stripped) || (cpf.valid? && cpf.stripped)

        values[:document] = document if document

        key.failure('is invalid') unless document
      end
    end
  end
end
