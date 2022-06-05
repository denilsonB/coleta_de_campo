require 'rails_helper'

RSpec.describe 'Users', type: :request do
  
  context 'Creating a new user' do
    describe 'POST User Create', type: :request do
      before do
        post '/users', params: {
            name: 'test rspec',
            password: '123456tT',
            password_confirmation: '123456tT',
            email: 'emailtest@mail.com',
            cpf: '55609041201'
        }
      end

      it 'is valid with status code 200' do
        p json
        expect(response).to have_http_status(:ok)
      end
      
      it "returns the name" do
        expect(json['name']).to eq('test rspec')
      end

      it "returns the email" do
        expect(json['email']).to eq('emailtest@mail.com')
      end

      it "returns the cpf" do
        expect(json['cpf']).to eq('55609041201')
      end
    end
    context "with invalid params" do 
        before do
            post '/users', params: {
                name: 'test rspec',
                password: '123456tT',
                password_confirmation: '123456tT',
                email: '',
                cpf: ''
            }
          end
          it 'returns a unprocessable entity status' do
            p json
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
  end
end