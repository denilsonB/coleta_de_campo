require 'rails_helper'

RSpec.describe 'Formulary', type: :request do
    describe "DELETE /destroy" do
        let!(:my_user) {FactoryBot.create(:user)}
        let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
        let!(:my_form){FactoryBot.create(:formulary)}

        before do
            delete "/formularies/#{my_form.id}", params: {format: :json}, headers: {
                "Authorization" => "#{token}"
            }
        end

        it "returns status code 200" do
            expect(response).to have_http_status(200)
        end
    end
end