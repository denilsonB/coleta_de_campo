require 'rails_helper'

module Mutations
    module Question
        RSpec.describe UpdateQuestion, type: :request do
            let!(:my_form) {FactoryBot.create(:formulary)}
            let!(:my_question){FactoryBot.create(:question,formulary: my_form)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query(id: my_question.id)}
                end
                
                it 'returns a visit' do
                    p json
                    data = json['data']['updateQuestion']['updatedQuestion']
                    expect(data).to include(
                        'id' => be_present,
                        'name' => 'question rspec updated'
                    )
                end
                it 'is valid with no errors' do 
                    data = json['data']['updateQuestion']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query(id:)
                <<~GQL
                mutation{
                    updateQuestion( input:{
                        id: #{id},
                        name: "question rspec updated"
                    }) {updatedQuestion{
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