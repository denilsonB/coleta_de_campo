require 'rails_helper'

module Mutations
    module Formulary
        RSpec.describe AddFormulary, type: :request do
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query}
                end
                
                it 'returns a formulary' do
                    p json
                    data = json['data']['addFormulary']['createdForm']
                    expect(data).to include(
                        'id' => be_present,
                        'name' => 'Rspec Form'
                    )
                end
                it 'is valid with no errors' do 
                    data = json['data']['addFormulary']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query
                <<~GQL
                mutation{
                    addFormulary( input:{
                        name: "Rspec Form",
                    }) {createdForm{
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