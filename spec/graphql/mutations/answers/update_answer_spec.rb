require 'rails_helper'

module Mutations
    module Answer
        RSpec.describe UpdateAnswer, type: :request do
            let!(:my_form){FactoryBot.create(:formulary)}
            let!(:my_question){FactoryBot.create(:question,formulary: my_form)}
            let!(:my_visit){ FactoryBot.create(:visit)}
            let!(:my_answer){FactoryBot.create(:answer,formulary:my_form, question:my_question, visit:my_visit)}
    
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query(id:my_answer.id)}
                end
                
                it 'returns a answer' do
                    p json
                    data = json['data']['updateAnswer']['updatedAnswer']
                    expect(data).to include(
                        'id' => be_present,
                        'content' => 'updated content',
                    )
                end
                it 'is valid with no errors' do 
                    data = json['data']['updateAnswer']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query(id:)
                <<~GQL
                mutation{
                    updateAnswer( input:{
                        id: #{id},
                        content: "updated content"
                    }) {updatedAnswer{
                            id
                            content
                        }
                    }
                }
                GQL
            end
        end
    end
end