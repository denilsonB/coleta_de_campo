require 'rails_helper'

RSpec.describe 'Questions', type: :request do
    let!(:my_user){FactoryBot.create(:user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
    let!(:my_form){FactoryBot.create(:formulary)}
    let!(:my_questions){FactoryBot.create_list(:question,10,formulary:my_form)}

    describe 'GET /index' do

        before do
            get "/formularies/#{my_form.id}/questions", params: {format: :json}, headers: {
                "Authorization" => "#{token}"
            }
        end

        it "return all users" do
            p json
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(:ok)
        end
    end
end