require 'rails_helper'

module Queries
    module Formularies
        RSpec.describe AllFormularies, type: :request do
            let!(:my_forms){FactoryBot.create_list(:formulary,10)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query}
                end
                it 'returns all formularies' do
                    expect(json['data']['allFormularies'].size).to eq(10)
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
                    allFormularies{
                        id
                        name
                    }
                }
                GQL
            end
        end
    end
end