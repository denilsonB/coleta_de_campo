require 'rails_helper'

module Mutations
    module Formulary
        RSpec.describe UpdateFormulary, type: :request do
            describe '.resolve' do
                let!(:my_form){FactoryBot.create(:formulary)}

                before do
                    post '/graphql', params: {query: query(id:my_form.id)}
                end
                
                it 'returns a formulary' do
                    p json
                    data = json['data']['updateFormulary']['updatedForm']
                    expect(data).to include(
                        'id' => be_present,
                        'name' => 'Rspec Form updated'
                    )
                end
                it 'is valid with no errors' do 
                    data = json['data']['updateFormulary']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query(id:)
                <<~GQL
                mutation{
                    updateFormulary( input:{
                        id:#{id}
                        name: "Rspec Form updated",
                    }) {updatedForm{
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