module Queries
    class OneAnswer < Queries::BaseQuery
        type Types::AnswerType, null: false
        
        argument :id, ID, required: true
    

        def resolve(id:)
            answer = Answer.find(id)

            rescue ActiveRecord::RecordNotFound => _e
                GraphQL::ExecutionError.new('Answer does not exist.')
            rescue ActiveRecord::RecordInvalid => e
                GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
            " #{e.record.errors.full_messages.join(', ')}")
        end
    end
end