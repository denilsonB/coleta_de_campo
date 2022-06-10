require 'rails_helper'

RSpec.describe 'Answer', type: :request do
    let!(:my_user){FactoryBot.create(:user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
    let!(:my_form){FactoryBot.create(:formulary)}
    let!(:my_question){FactoryBot.create(:question,formulary: my_form)}
    let!(:my_visit){ FactoryBot.create(:visit)}
    let!(:my_answer){FactoryBot.create(:answer,formulary:my_form, question:my_question, visit:my_visit)}

    context 'Updating Answer information' do
        describe 'PUT Answer update', type: :request do
            before do
                put "/formularies/#{my_form.id}/questions/#{my_question.id}/answers/#{my_answer.id}", params: {
                        content: "Updated content",
                        answered_at: Time.current
                }, headers: {
                "Authorization" => "#{token}"
            }
            end
            
            it "is valid with status code 200" do
                p json
                expect(response.status).to eq(200)
            end
            it "updated the content" do
                expect(json['content']).to eq('Updated content')
            end
        end
        context "with invalid params" do 
            before do
                put "/formularies/#{my_form.id}/questions/#{my_question.id}/answers/#{my_answer.id}", params: {
                        content: "Updated content",
                        visit_id: nil,
                        answered_at: Time.current
                }, headers: {
                "Authorization" => "#{token}"
            }
            end           
            it 'returns a unprocessable entity status if visit_id is invalid' do
                p json
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end 
    end
end