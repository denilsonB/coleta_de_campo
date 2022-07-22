require 'rails_helper'

module Mutations
    module Users
        RSpec.describe UpdateUser, type: :request do
            let!(:my_user) {FactoryBot.create(:user)}
            describe '.resolve' do

                before do
                    post '/graphql', params: {query: query(id:my_user.id)}
                end

                it 'returns a user' do
                    p json
                    data = json['data']['updateUser']['updatedUser']
                    expect(data).to include(
                        'id' => be_present,
                        'name' => 'updated name',
                        'email' => 'updated@mail.com',
                        'cpf' => '90504530151'
                    )
                end
                it 'is valid with no errors' do 
                    data = json['data']['updateUser']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query(id:)
                <<~GQL
                    mutation{
                        updateUser( input: {
                                id: #{id},
                                name: "updated name",
                                email: "updated@mail.com",
                                cpf: "90504530151",
                                password: "#{my_user.password}"
                            })
                            {updatedUser{
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