require 'rails_helper'

module Mutations
    module Visits
        RSpec.describe DestroyVisit, type: :request do
            let!(:my_user) {FactoryBot.create(:user)}
            let!(:my_visit){FactoryBot.create(:visit,user: my_user)}
            describe '.resolve' do
                before do
                    post '/graphql', params: {query: query(id:my_visit.id)}
                end

                it 'returns an id' do
                    p json
                    data = json['data']['destroyVisit']
                    expect(data).to include(
                        'id' => be_present
                    )
                end
            end

            def query(id:)
                <<~GQL
                    mutation{
                        destroyVisit(
                            input: {id: #{id}
                        })
                        {
                            id
                        }
                    }
                GQL
            end
        end
    end
end