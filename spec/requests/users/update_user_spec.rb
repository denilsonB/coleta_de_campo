require 'rails_helper'

RSpec.describe "User", type: :request do
    let!(:my_user) {FactoryBot.create(:user)}

    context "Updating user information " do
        describe "PUT User update", type: :request do 
        before do
            put "/users/#{my_user.id}", params: {
                    name: "updated name",
                    email: "updated@mail.com",
                    cpf: "90504530151",
                    password: my_user.password
                
            }
        end
        it "is valid with status code 200" do
            p json
            expect(response.status).to eq(200)
        end
        
        it "updated the name" do
            expect(json["name"]).to eq("updated name")
        end
        
        it "updated the email" do
            expect(json["email"]).to eq("updated@mail.com")
        end
        
        it "updated the cpf" do
            expect(json["cpf"]).to eq("90504530151")
        end
    end
    context "without password" do 
        before do
            put "/users/#{my_user.id}", params: {
                    name: "updated name",
                    email: "updated@mail.com",
                    cpf: "90504530151"
            }
          end
          it 'returns a unprocessable entity status' do
            p json
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
    end
end
