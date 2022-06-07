require 'rails_helper'

RSpec.describe 'Visits', type: :request do
    let!(:my_user){FactoryBot.create(:user)}
    let!(:my_visit){FactoryBot.create(:visit,user: my_user)}

    context 'Updating Visit information' do
        describe 'PUT Visit update', type: :request do
            before do
                put "/users/#{my_user.id}/visits/#{my_visit.id}", params: {
                        date: Date.tomorrow,
                        status: 2,
                        user_id: my_user.id,
                        checkin_at: 3.days.ago,
                        checkout_at: 2.day.ago
                }
            end
            
            it "is valid with status code 200" do
                p json
                expect(response.status).to eq(200)
            end
            
            it "updated the date" do
                expect(json['date']).to eq(Visit.find(json['id']).date.to_s)
            end

            it "updated the status" do
                expect(json['status']).to eq(Visit.find(json['id']).status)
            end
    
            it "updated the checkin_at" do
                expect(Time.parse(json['checkin_at'])).to eq(Time.parse(Visit.find(json['id']).checkin_at.to_s))
            end
    
            it "updated the checkout_at" do
                expect(Time.parse(json['checkout_at'])).to eq(Time.parse(Visit.find(json['id']).checkout_at.to_s))
            end
        end
        context "with invalid params" do
            before do
                put "/users/#{my_user.id}/visits/#{my_visit.id}", params: {
                        date: "",
                        status: 2,
                        user_id: my_user.id,
                        checkin_at: "",
                        checkout_at: 2.day.ago
                }
            end
            it 'returns a unprocessable entity status' do
                p json
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end
end