class Note < ApplicationRecord
  belongs_to :user, inverse_of: :notes
  belongs_to :fiat_currency

  enum sentiment: {
    patient: 0,
    resilient: 1,
    bored: 2,
    hopeful: 3,
    optimistic: 4,
    fomo: 5,
    euphoric: 6,
    skeptical: 7,
    cautious: 8,
    regretful: 9,
    anxious: 10,
    panic: 11,
    exhausted: 12
  }

  def self.ransackable_attributes(auth_object = nil)
    ['created_at', 'price', 'sentiment']
  end

  def self.ransackable_associations(auth_object = nil)
    ["fiat_currency", "user"]
  end
end
