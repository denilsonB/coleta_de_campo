module Mutations
    class AddAnswer < Mutations::BaseMutation
        argument :content, String, required: true
        argument :formulary_id, ID, required: true
        argument :question_id, ID, required: true
        argument :visit_id, ID, required: true
        argument :answered_at, GraphQL::Types::ISO8601DateTime, required: true

        field :created_answer, Types::AnswerType, null: true
        field :errors, [String], null: false

        def resolve(**params)
            service = AnswerServices::Create.call(params)

            if service.success?
                answer = service.result
                {
                    created_answer: answer,
                    errors: []
                }
            else
                {
                    created_answer: nil,
                    errors: service.errors.full_messages
                }
            end
        end
    end
end