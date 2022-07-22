require 'rails_helper'

module Queries
    module Questions
        RSpec.describe AllQuestions, type: :request do
            let!(:my_form){FactoryBot.create(:formulary)}
            let!(:my_questions){FactoryBot.create_list(:question,10,formulary:my_form)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query}
                end
                it 'returns all questions' do
                    expect(json['data']['allQuestions'].size).to eq(10)
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
                    allQuestions{
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