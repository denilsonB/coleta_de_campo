require 'rails_helper'

RSpec.describe "User", type: :request do
    describe 'POST /create' do
        context "with valid parameters" do 
            let!(:my_user) {FactoryBot.create(:user)}
        
        before do 
            post users_url, params:
                        { user:{
                            name: my_user.name,
                            password: my_user.password,
                            password_confirmation: my_user.password_confirmation,
                            email: my_user.email,
                            cpf: my_user.cpf
                        } }
        end
        it "returns the name " do
            #expect(response).to be_successful
            expect(json['name']).to eq(my_user.name)
        end
    end
    end
end
