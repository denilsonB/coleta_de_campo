require 'rails_helper'

module Mutations
    module Visits
        RSpec.describe UpdateVisit, type: :request do
            let!(:my_user) {FactoryBot.create(:user)}
            let!(:my_visit){FactoryBot.create(:visit,user: my_user)}
            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query(id:my_visit.id,user_id: my_user.id)}
                end
                
                it 'returns a visit' do
                    p json
                    data = json['data']['updateVisit']['updatedVisit']
                    expect(data).to include(
                        'id' => be_present,
                        'date' => Date.tomorrow.iso8601.to_s,
                        'checkinAt' => 3.days.ago.iso8601.to_s,
                        'checkoutAt' => 2.day.ago.iso8601.to_s,
                        'user' => {'id' => my_user.id.to_s,'name' => my_user.name }
                    )
                end
                it 'is valid with no errors' do 
                    data = json['data']['updateVisit']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query(id:,user_id:)
                <<~GQL
                mutation{
                    updateVisit( input:{
                        id: #{id}
                        date: "#{Date.tomorrow.iso8601}",
                        userId: #{user_id},
                        checkinAt: "#{3.days.ago.iso8601}",
                        checkoutAt: "#{2.day.ago.iso8601}"
                    }) {updatedVisit{
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