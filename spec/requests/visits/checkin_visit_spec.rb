require 'rails_helper'

RSpec.describe 'Visits', type: :request do
    let!(:my_user){FactoryBot.create(:user)}
    let!(:my_visit){FactoryBot.create(:visit,user: my_user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}

    context 'Checkin Visit ' do
        describe 'POST Visit checkin', type: :request do
            before do
                post "/users/#{my_user.id}/visits/#{my_visit.id}/checkin", params: {}, headers: {
                "Authorization" => "#{token}"
            }
            end
            
            it "is valid with status code 200" do
                p json
                expect(response.status).to eq(200)
            end
        end
    end
end