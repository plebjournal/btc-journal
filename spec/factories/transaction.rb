# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    transaction_date { Date.today }
    btc { 1_130_000 }
    fiat { 1_000 }
    transaction_type { 'buy' }
    association :fiat_currency
    association :user

    trait :last_week do
      transaction_date { Date.today - 1.week }
    end

    trait :sell do
      transaction_type { 'sell' }
    end

    trait :income do
      transaction_type { 'income' }
    end

    trait :spend do
      transaction_type { 'spend' }
    end
  end
end