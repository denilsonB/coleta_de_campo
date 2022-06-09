require 'rails_helper'

RSpec.describe "Formulary", type: :request do
    let!(:my_user) {FactoryBot.create(:user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
    let!(:my_forms){FactoryBot.create_list(:formulary,2)}


    context "Updating formulary information " do
        describe "PUT Formulary update", type: :request do 
            before do
                put "/formularies/#{my_forms[0].id}", params: {
                        name: "updated name"
                }, headers: {"Authorization" => "#{token}"}
            end
            it "is valid with status code 200" do
                p json
                expect(response.status).to eq(200)
            end

            it "updated the name" do
                expect(json['name']).to eq('updated name')
            end
        end
        context "with invalid params" do
            before do
                put "/formularies/#{my_forms[0].id}", params: {
                        name: my_forms[1].name
                }, headers: {"Authorization" => "#{token}"}
            end
            it 'returns a unprocessable entity status' do
                p json
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end 
end