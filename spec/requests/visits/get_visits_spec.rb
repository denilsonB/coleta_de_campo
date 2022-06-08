require 'rails_helper'

RSpec.describe 'Visits', type: :request do
    let!(:my_user){FactoryBot.create(:user)}
    let!(:my_visit){ FactoryBot.create_list(:visit,10, user: my_user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}

    describe 'GET /index' do
        before do
            get "/users/#{my_user.id}/visits", params: {format: :json}, headers: {
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