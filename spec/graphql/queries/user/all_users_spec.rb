require 'rails_helper'

module Queries
    module Users
        RSpec.describe AllUsers, type: :request do
            let!(:my_user) {FactoryBot.create_list(:user,10)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query}
                end
                it 'returns all users' do
                    expect(json['data']['allUsers'].size).to eq(10)
                end
                it 'is valid with no errors' do
                     p json
                    data = json['data']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query
                <<~GQL
                query{
                    allUsers{
                        id
                        name
                    }
                }
                GQL
            end
        end
    end
end