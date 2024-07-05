module ApplicationHelper
  include Importmap::ImportmapTagsHelper

  def fiat_code
    current_user.fiat_currency.code
  end
end
