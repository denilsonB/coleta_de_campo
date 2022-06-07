require 'rails_helper'

RSpec.describe 'Visits', type: :request do
    let!(:my_user){FactoryBot.create(:user)}

    context 'Creating a new visit' do
        describe 'POST Visit Create', type: :request do
        before do
            post "/users/#{my_user.id}/visits", params: {
                    date: Date.current,
                    status: 0,
                    user_id: my_user.id,
                    checkin_at: 2.days.ago,
                    checkout_at: 1.day.ago
            }
        end
        it 'is valid with status code 200' do
            p json
            expect(response).to have_http_status(:ok)
        end

        it "returns the date" do
            expect(json['date']).to eq(Visit.find(json['id']).date.to_s)
        end

        it "returns the status" do
            expect(json['status']).to eq(Visit.find(json['id']).status)
        end

        it "returns the checkin_at" do
            expect(Time.parse(json['checkin_at'])).to eq(Time.parse(Visit.find(json['id']).checkin_at.to_s))
        end

        it "returns the checkout_at" do
            expect(Time.parse(json['checkout_at'])).to eq(Time.parse(Visit.find(json['id']).checkout_at.to_s))
        end
    end
    context "with invalid params" do
        before do
            post "/users/#{my_user.id}/visits", params: {
                date: Date.current,
                status: 0,
                user_id: my_user.id,
                checkin_at: "",
                checkout_at: ""
        }
        end
        it 'returns a unprocessable entity status' do
            p json
            expect(response).to have_http_status(:unprocessable_entity)
        end
    end
    end
end