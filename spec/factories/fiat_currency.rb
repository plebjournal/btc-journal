# frozen_string_literal: true

FactoryBot.define do
  factory :fiat_currency do
    code { 'CAD' }
    name { 'Canadian Dollar' }
  end
end