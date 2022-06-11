require 'rails_helper'

RSpec.describe "User", type: :request do
    let!(:my_user) {FactoryBot.create(:user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}

    context "Login user " do
        describe "POST /auth/login", type: :request do 
            before do
                post "/auth/login", params: {
                        email: my_user.email,
                        password: my_user.password
                    
                }
            end
            it "is valid with status code 200" do
                p json
                expect(response.status).to eq(200)
            end
            
            it "returns the token" do
                expect(json['token']).to eq(token)
            end

            it "returns the name " do
                expect(json['name']).to eq(my_user.name)
            end 
        end
        
        context "with invalid password" do 
            before do
                post "/auth/login", params: {
                        email: my_user.email,
                        password: nil
                    
                }
            end
            it 'returns  unauthorized' do
                p json
                expect(response).to have_http_status(:unauthorized)
            end
        end
    end
end