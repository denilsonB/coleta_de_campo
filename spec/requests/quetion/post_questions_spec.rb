require 'rails_helper'

RSpec.describe 'Questions', type: :request do
    let!(:my_user){FactoryBot.create(:user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
    let!(:my_form){FactoryBot.create(:formulary)}

    context 'Creating a new question' do
        describe 'POST Question Create', type: :request do
            before do
                post "/formularies/#{my_form.id}/questions", params: {
                    name: "Rspec question",
                    formulary_id: my_form.id,
                    question_type: 1,
                    image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/images/Question.png")
                },headers: {
                    "Authorization" => "#{token}"
                }
            end
            it 'is valid with status code 200' do
                p json
                expect(response).to have_http_status(:ok)
            end
            
            it "returns the name" do
                expect(json['name']).to eq('Rspec question')
            end
            
            it "returns the question type" do
                expect(json['question_type']).to eq("FOTO")
            end

            it "image is atteched" do
                expect(Question.last.image).to be_attached
            end
        end
        context "with invalid params" do
            before do
                post "/formularies/#{my_form.id}/questions", params: {
                    name: "Rspec question",
                    formulary_id: my_form.id,
                    question_type: 1
                },headers: {
                    "Authorization" => "#{token}"
                }
            end
            it 'returns a unprocessable entity status if type is 1 and no image is send' do
                p json
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end 
end 