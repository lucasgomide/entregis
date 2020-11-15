class BaseUpdatingContract < ApplicationContract
  params do
    required(:id).value(:integer)
  end
end
