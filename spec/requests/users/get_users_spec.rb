require 'rails_helper'

RSpec.describe 'Users', type: :request do
    describe 'GET /index' do
        let!(:my_user){FactoryBot.create_list(:user,10)}
        let!(:token) {JsonWebToken.encode(user_id: my_user[0].id)}

        before do
            get '/users', params: {format: :json}, headers: {
                "Authorization" => "#{token}"
            }
        end

        it "return all users" do
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(:ok)
          end
    end
end