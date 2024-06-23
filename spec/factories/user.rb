# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'email1@example.com' }
    password { 'password123' }
  end
end