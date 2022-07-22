require 'rails_helper'

module Mutations
    module Answer
        RSpec.describe AddAnswer, type: :request do
            let!(:my_form){FactoryBot.create(:formulary)}
            let!(:my_question){FactoryBot.create(:question,formulary: my_form)}
            let!(:my_visit){ FactoryBot.create(:visit)}

            describe '.resolve' do
                
                before do
                    post '/graphql', params: {query: query(form_id: my_form.id,question_id:my_question.id,visit_id:my_visit.id)}
                end
                
                it 'returns a answer' do
                    p json
                    data = json['data']['addAnswer']['createdAnswer']
                    expect(data).to include(
                        'id' => be_present,
                        'content' => 'answer rspec',
                        'formulary' => {'id' => my_form.id.to_s,'name' => my_form.name},
                        'question' => {'id' => my_question.id.to_s, 'name' => my_question.name},
                        'visit' => {'id' => my_visit.id.to_s, 'date' => Date.current.iso8601}
                    )
                end
                it 'is valid with no errors' do 
                    data = json['data']['addAnswer']
                    expect(data.dig('errors')).to be_nil
                end
            end

            def query(form_id:,question_id:,visit_id:)
                <<~GQL
                mutation{
                    addAnswer( input:{
                        content: "answer rspec",
                        formularyId: #{form_id},
                        questionId: #{question_id},
                        visitId: #{visit_id},
                        answeredAt: "#{Date.current.iso8601}"
                    }) {createdAnswer{
                            id
                            content
                            formulary{
                                id
                                name
                            }
                            question{
                                id
                                name
                            }
                            visit{
                                id
                                date
                            }
                        }
                    }
                }
                GQL
            end
        end
    end
end