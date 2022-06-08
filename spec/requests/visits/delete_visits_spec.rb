require 'rails_helper'

RSpec.describe 'Visit', type: :request do
    describe "DELETE /destroy" do
        let!(:my_user) {FactoryBot.create(:user)}
        let!(:my_visit) {FactoryBot.create(:visit,user: my_user)}
        let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
        before do
            delete "/users/#{my_user.id}/visits/#{my_visit.id}", params: {format: :json}, headers: {
                "Authorization" => "#{token}"
            }
        end

        it "returns status code 200" do
            expect(response).to have_http_status(200)
        end
    end
end