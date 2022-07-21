module Mutations
    class AddQuestion < Mutations::BaseMutation
        argument :name, String, required: true
        argument :formulary_id, ID, required: true

        field :created_question, Types::QuestionType, null: true
        field :errors, [String], null: false

        def resolve(**args)
            service = QuestionServices::Create.call(args)

            if service.success?
                question = service.result
                {
                    created_question: question,
                    errors: []
                }
            else
                {
                    created_question: nil,
                    errors: service.errors.full_messages
                }
            end
        end
    end
end