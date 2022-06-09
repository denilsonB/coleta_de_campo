require 'rails_helper'

RSpec.describe 'Formularies', type: :request do
    describe "GET /index" do
        let!(:my_forms){FactoryBot.create_list(:formulary,10)}
        let!(:my_user) {FactoryBot.create(:user)}
        let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
        
        before do 
            get '/formularies',params: {format: :json}, headers: {
                "Authorization" => "#{token}"
            }
        end

        it "returns all formularies" do
            p json
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(:ok)
        end
    end 
end