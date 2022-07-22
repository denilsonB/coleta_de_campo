require 'rails_helper'

module Mutations
    module Users
        RSpec.describe DestroyUser, type: :request do
            let!(:my_user) {FactoryBot.create(:user)}
            describe '.resolve' do
                before do
                    post '/graphql', params: {query: query(id:my_user.id)}
                end

                it 'returns an id' do
                    p json
                    data = json['data']['destroyUser']
                    expect(data).to include(
                        'id' => be_present
                    )
                end
            end

            def query(id:)
                <<~GQL
                    mutation{
                        destroyUser(
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