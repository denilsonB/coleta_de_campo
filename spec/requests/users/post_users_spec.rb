require 'rails_helper'

RSpec.describe "User", type: :request do
    describe 'POST /create' do
        context "with valid parameters" do 
            let!(:my_user) {FactoryBot.create(:user)}
        
            before do
                post '/users', params:
                            { 
                                name: my_user.name,
                                password: my_user.password,
                                password_confirmation: my_user.password_confirmation,
                                email: my_user.email,
                                cpf: my_user.cpf
                            } 
            end
        it "returns the name " do
            #byebug
            #expect(response).to eq(json)
            p json
            expect(response).to be_successful
            #expect(json['email']).to eq(my_user.email)
        end
    end
    end
end
