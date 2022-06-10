require 'rails_helper'

RSpec.describe 'Questions', type: :request do
    let!(:my_user){FactoryBot.create(:user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
    let!(:my_form){FactoryBot.create(:formulary)}
    let!(:my_question){FactoryBot.create(:question,formulary: my_form)}
    let!(:my_visit){ FactoryBot.create(:visit)}
    let!(:my_answer){FactoryBot.create(:answer,formulary:my_form, question:my_question, visit:my_visit)}

    describe 'GET /index' do

        before do
            get "/formularies/#{my_form.id}/questions/#{my_question.id}/answers", params: {format: :json}, headers: {
                "Authorization" => "#{token}"
            }
        end

        it "return answer" do
            p json
            expect(json['content']).to eq(my_answer.content)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(:ok)
        end
    end
end