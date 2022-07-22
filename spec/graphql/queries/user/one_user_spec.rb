require 'rails_helper'

module Queries
    module Users
        RSpec.describe OneUser, type: :request do
            let!(:my_user) {FactoryBot.create(:user)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query(id:my_user.id)}
                end
                it 'returns one user' do
                    p json
                    expect(json['data'].size).to eq(1)
                end
                it 'is valid with no errors' do
                    data = json['data']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query(id:)
                <<~GQL
                query{
                    oneUser(id:#{id}){
                        id
                        name
                    }
                }
                GQL
            end
        end
    end
end