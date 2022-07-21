module Mutations
    class UpdateAnswer < Mutations::BaseMutation
        argument :id, ID, required: true
        argument :content, String, required: true

        field :updated_answer, Types::AnswerType, null: true
        field :errors, [String], null: false

        def resolve(id:,**params)
            service = AnswerServices::Update.call(id,params)

            if service.success?
                answer = service.result
                {
                    updated_answer: answer,
                    errors: []
                }
            else
                {
                    updated_answer: nil,
                    errors: service.errors.full_messages
                }
            end
        end
    end
end