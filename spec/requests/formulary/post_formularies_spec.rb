require 'rails_helper'

RSpec.describe 'Formularies', type: :request do
    let!(:my_user) {FactoryBot.create(:user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
  
    context 'Creating a new formulary' do
        describe 'POST Formulary Create', type: :request do
            before do
                post '/formularies', params: {
                    name: "Form name"
            }, headers: {"Authorization" => "#{token}"}
            end

            it 'is valid with status code 200' do
                p json
                expect(response).to have_http_status(:ok)
            end

            it "returns the name" do
                expect(json['name']).to eq('Form name')
            end
        end
    context "with invalid params" do
        before do
            post '/formularies', params: {
                name: ""
        }, headers: {"Authorization" => "#{token}"}
        end
        it 'returns a unprocessable entity status' do
            p json
            expect(response).to have_http_status(:unprocessable_entity)
        end
    end
    end
end