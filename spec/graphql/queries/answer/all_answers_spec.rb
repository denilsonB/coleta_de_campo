require 'rails_helper'

module Queries
    module Answers
        RSpec.describe AllAnswers, type: :request do
            let!(:my_form){FactoryBot.create(:formulary)}
            let!(:my_question){FactoryBot.create(:question,formulary: my_form)}
            let!(:my_visit){ FactoryBot.create(:visit)}
            let!(:my_answer){FactoryBot.create_list(:answer,10,formulary:my_form, question:my_question, visit:my_visit)}
            
            describe '.resolve' do 
                before do
                    post '/graphql', params: {query: query}
                end

                it 'returns all answers' do
                    expect(json['data']['allAnswers'].size).to eq(10)
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
                    allAnswers{
                        id
                        content
                        question{
                            id
                            name
                        }
                        visit{
                            id
                            date
                            user{
                                id
                                name
                            }
                        }
                    }
                }
                GQL
            end
        end
    end
end