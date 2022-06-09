require 'rails_helper'

RSpec.describe 'Question', type: :request do
    let!(:my_user){FactoryBot.create(:user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
    let!(:my_form){FactoryBot.create(:formulary)}
    let!(:my_question){FactoryBot.create(:question,formulary:my_form)}

    context 'Updating Question information' do
        describe 'PUT Question update', type: :request do
            before do
                put "/formularies/#{my_form.id}/questions/#{my_question.id}", params: {
                        name: "Updated name",
                        question_type: 0,
                        image: nil
                }, headers: {
                "Authorization" => "#{token}"
            }
            end
            
            it "is valid with status code 200" do
                p json
                expect(response.status).to eq(200)
            end
            
            it "updated the name" do
                expect(json['name']).to eq('Updated name')
            end
            
            it "updated the question type" do
                expect(json['question_type']).to eq('TEXTO')
            end

            it "image is not atteched" do
                expect(Question.last.image).to_not be_attached
            end
        end
        context "with invalid params" do
            before do
                put "/formularies/#{my_form.id}/questions/#{my_question.id}", params: {
                        name: "Updated name",
                        question_type: 1,
                        image: nil
                }, headers: {
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