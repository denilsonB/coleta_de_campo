require 'rails_helper'

RSpec.describe 'Visit', type: :request do
    describe "DELETE /destroy" do
        let!(:my_user) {FactoryBot.create(:user)}
        let!(:my_visit) {FactoryBot.create(:visit,user: my_user)}

        before do
            delete "/users/#{my_user.id}/visits/#{my_visit.id}"
        end

        it "returns status code 200" do
            expect(response).to have_http_status(200)
        end
    end
end