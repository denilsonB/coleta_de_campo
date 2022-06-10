require 'rails_helper'

RSpec.describe 'Answers', type: :request do
    let!(:my_user){FactoryBot.create(:user)}
    let!(:token) {JsonWebToken.encode(user_id: my_user.id)}
    let!(:my_form){FactoryBot.create(:formulary)}
    let!(:my_question){FactoryBot.create(:question,formulary: my_form)}
    let!(:my_visit){ FactoryBot.create(:visit)}

    context 'Creating a new answer' do
        describe 'POST Answer Create', type: :request do
            before do
                post "/formularies/#{my_form.id}/questions/#{my_question.id}/answers", params: {
                    content: "Rspec answer",
                    visit_id: my_visit.id,
                    answered_at: Time.current
                },headers: {
                    "Authorization" => "#{token}"
                }
            end
            it 'is valid with status code 200' do
                p json
                expect(response).to have_http_status(:ok)
            end

            it "returns the content" do
                expect(json['content']).to eq('Rspec answer')
            end

            it "returns the formulary_id" do
                expect(json['formulary_id']).to eq(my_form.id)
            end

            it "returns the question_id" do
                expect(json['question_id']).to eq(my_question.id)
            end

            it "returns the visit_id" do
                expect(json['visit_id']).to eq(my_visit.id)
            end
        end
        context "with invalid params" do 
            before do
                post "/formularies/#{my_form.id}/questions/#{my_question.id}/answers", params: {
                    content: "Rspec answer",
                    visit_id: nil,
                    answered_at: Time.current
                },headers: {
                    "Authorization" => "#{token}"
                }
            end
            it 'returns a unprocessable entity status ' do
                p json
                #byebug
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end
end
            