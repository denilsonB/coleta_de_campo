require 'rails_helper'

module Queries
    module Formularies
        RSpec.describe OneFormulary, type: :request do
            let!(:my_form){FactoryBot.create(:formulary)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query(id:my_form.id)}
                end
                it 'returns one formulary' do
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
                    oneFormulary(id:#{id}){
                        id
                        name
                    }
                }
                GQL
            end
        end
    end
end