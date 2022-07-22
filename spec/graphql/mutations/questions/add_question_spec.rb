require 'rails_helper'

module Mutations
    module Question
        RSpec.describe AddQuestion, type: :request do
            let!(:my_form) {FactoryBot.create(:formulary)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query(form_id: my_form.id)}
                end
                
                it 'returns a visit' do
                    p json
                    data = json['data']['addQuestion']['createdQuestion']
                    expect(data).to include(
                        'id' => be_present,
                        'name' => 'question rspec'
                    )
                end
                it 'is valid with no errors' do 
                    data = json['data']['addQuestion']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query(form_id:)
                <<~GQL
                mutation{
                    addQuestion( input:{
                        name: "question rspec",
                        formularyId: #{form_id}
                    }) {createdQuestion{
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