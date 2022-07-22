require 'rails_helper'

module Queries
    module Visits
        RSpec.describe AllVisits, type: :request do
            let!(:my_user){FactoryBot.create(:user)}
            let!(:my_visit){FactoryBot.create_list(:visit,10,user: my_user)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query}
                end
                it 'returns all visits' do
                    expect(json['data']['allVisits'].size).to eq(10)
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
                    allVisits{
                        id
                        date
                        user{
                            id
                            name
                        }
                    }
                }
                GQL
            end
        end
    end
end