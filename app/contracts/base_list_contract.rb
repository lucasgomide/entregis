class BaseListContract < ApplicationContract
  params do
    optional(:page).hash do
      optional(:size).value(:integer, gt?: 0, lteq?: 100)
      optional(:number).value(:integer)
    end
  end
end
