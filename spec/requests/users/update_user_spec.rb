require 'rails_helper'

RSpec.describe "User", type: :request do
    let!(:my_user) {FactoryBot.create(:user)}

    scenario "with valid attributes" do
        put "/users/#{my_user.id}", params: {
            user: {
                name: "updated name",
                password: my_user.password
            }
        }
        #expect(response.status).to eq(200)
        expect(json[:name]).to eq("updated name")
    end
end
