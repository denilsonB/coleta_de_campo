require 'rails_helper'

module Mutations
    module Users
        RSpec.describe AddUser, type: :request do
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query}
                end
                
                it 'returns a user' do
                    p json
                    data = json['data']['addUser']['createdUser']
                    expect(data).to include(
                        'id' => be_present,
                        'name' => 'Rspec test',
                        'email' => 'rspec@mail.com',
                        'cpf' => '55385674869'
                    )
                end
                it 'is valid with no errors' do 
                    data = json['data']['addUser']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query
                <<~GQL
                mutation{
                    addUser( input:{
                        name: "Rspec test",
                        password: "123456Tt",
                        passwordConfirmation: "123456Tt",
                        email: "rspec@mail.com",
                        cpf: "55385674869"
                    }) {createdUser{
                            id
                            name
                            email
                            cpf
                        }
                    }
                }
                GQL
            end
        end
    end
end