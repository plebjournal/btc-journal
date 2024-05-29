class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :transactions, dependent: :destroy
  has_one :user_setting, dependent: :destroy, inverse_of: :user

  def fiat_currency
    user_setting&.fiat_currency || FiatCurrency.first
  end

  def timezone
    user_setting&.time_zone || 'America/Los_Angeles'
  end

  def local_zone
    TZInfo::Timezone.get(timezone)
  end

  def local_time
    local_zone.now
  end
end
