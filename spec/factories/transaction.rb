# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    transaction_date { Date.today }
    btc { 1_130_000 }
    fiat { 1_000 }
    transaction_type { 'buy' }
    association :fiat_currency
    association :user
  end
end