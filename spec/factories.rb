FactoryBot.define do
    factory :user do
      
      sequence(:name) { |n| "user#{n}" }
      sequence(:email) { |n| "user#{n}@example.com" }
      sequence(:cpf) { Faker::CPF.numeric }
      password { "Password3" }
      password_confirmation {'Password3'}
    end
  end