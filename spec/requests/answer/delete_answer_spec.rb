require 'rails_helper'

RSpec.describe 'Question', type: :request do
    let!(:my_user){FactoryBot.create(:user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
    let!(:my_form){FactoryBot.create(:formulary)}
    let!(:my_question){FactoryBot.create(:question,formulary: my_form)}
    let!(:my_answer){FactoryBot.create(:answer,formulary:my_form, question:my_question)}

    describe "DELETE /destroy" do
        before do
            delete "/formularies/#{my_form.id}/questions/#{my_question.id}/answers/#{my_answer.id}", params: {format: :json}, headers: {
                "Authorization" => "#{token}"
            }
        end

        it "returns status code 200" do
            expect(response).to have_http_status(200)
        end
    end
end