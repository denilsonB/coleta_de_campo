FactoryBot.define do
    factory :user do
      sequence(:name) { |n| "user#{n}" }
      sequence(:email) { Faker::Internet.email}
      sequence(:cpf) { Faker::CPF.numeric }
      password { "Password3" }
      password_confirmation {'Password3'}
    end
    
    factory :visit do 
      sequence(:date) {Faker::Date.between(from: Date.today,to: 2.days.from_now)}
      sequence(:status) {rand(0..2)}
      association :user
      sequence(:checkin_at) {Faker::Time.between(from: 3.days.ago,to: 2.days.ago)}
      checkout_at {1.day.ago}
    end
    
    factory :formulary do
      sequence(:name) { |n| "formulary#{n}" }
    end

    factory :question do
      sequence(:name) {|n| "question#{n}" }
      association :formulary
      question_type {1}
      image {Rack::Test::UploadedFile.new("#{Rails.root}/spec/images/Question.png",'image/png')}
    end

  end