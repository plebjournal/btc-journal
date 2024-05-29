class UserSetting < ApplicationRecord
  belongs_to :user, inverse_of: :user_setting
  belongs_to :fiat_currency
end
