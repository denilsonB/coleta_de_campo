require 'rails_helper'

module Queries
    module Questions
        RSpec.describe OneQuestion, type: :request do
            let!(:my_form){FactoryBot.create(:formulary)}
            let!(:my_question){FactoryBot.create(:question,formulary:my_form)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query(id:my_question.id)}
                end
                it 'returns one question' do
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
                    oneQuestion(id:#{id}){
                        id
                        name
                        formulary{
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