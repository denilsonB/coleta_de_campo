require 'rails_helper'

module Queries
    module Visits
        RSpec.describe OneVisit, type: :request do
            let!(:my_user){FactoryBot.create(:user)}
            let!(:my_visit){FactoryBot.create(:visit,user: my_user)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query(id:my_visit.id)}
                end
                it 'returns one visit' do
                    expect(json['data'].size).to eq(1)
                end
                it 'is valid with no errors' do
                     p json
                    data = json['data']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query(id:)
                <<~GQL
                query{
                    oneVisit(id:#{id}){
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