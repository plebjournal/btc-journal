class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :transactions, dependent: :destroy

  def local_zone
    TZInfo::Timezone.get('America/Los_Angeles')
  end

  def local_time
    local_zone.now
  end
end
