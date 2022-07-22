require 'rails_helper'

module Mutations
    module Visits
        RSpec.describe AddVisit, type: :request do
            let!(:my_user) {FactoryBot.create(:user)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query(user_id: my_user.id)}
                end
                
                it 'returns a visit' do
                    p json
                    data = json['data']['addVisit']['createdVisit']
                    expect(data).to include(
                        'id' => be_present,
                        'date' => Date.current.iso8601.to_s,
                        'checkinAt' => 2.days.ago.iso8601.to_s,
                        'checkoutAt' => 1.day.ago.iso8601.to_s,
                        'user' => {'id' => my_user.id.to_s,'name' => my_user.name }
                    )
                end
                it 'is valid with no errors' do 
                    data = json['data']['addVisit']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query(user_id:)
                <<~GQL
                mutation{
                    addVisit( input:{
                        date: "#{Date.current.iso8601}",
                        status: 0,
                        userId: #{user_id},
                        checkinAt: "#{2.days.ago.iso8601}",
                        checkoutAt: "#{1.day.ago.iso8601}"
                    }) {createdVisit{
                            id
                            date
                            checkinAt
                            checkoutAt
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