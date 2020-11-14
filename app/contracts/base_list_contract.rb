class BaseListContract < ApplicationContract
  params do
    optional(:per_page).value(:integer, gt?: 0, lteq?: 100)
    optional(:page).value(:integer)
  end
end
