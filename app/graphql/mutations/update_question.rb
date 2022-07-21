module Mutations
    class UpdateQuestion < Mutations::BaseMutation
        argument :id, ID, required: true
        argument :name, String, required: false
        argument :question_type, Integer, required: false

        field :updated_question, Types::QuestionType, null: true
        field :errors, [String], null:false

        def resolve(id:,**args)
            service = QuestionServices::Update.call(id,args)

            if service.success?
                question = service.result
                {
                    updated_question: question,
                    errors: []
                }
            else
                {
                    updated_question: nil,
                    errors: service.errors.full_messages
                }
            end
        end

    end
end