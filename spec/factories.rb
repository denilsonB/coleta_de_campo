FactoryBot.define do
    factory :user do
      name { "Factory tes" }
      email { "factory@mail.com" }
      password { "123456Ff"}
      password_confirmation { "123456Ff"}
      cpf { "65221891352"}
    end
  end