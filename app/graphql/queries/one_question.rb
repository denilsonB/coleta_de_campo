module Queries
    class OneQuestion < Queries::BaseQuery
        type Types::QuestionType, null: false
        argument :id, ID, required: true

        def resolve(id:)
            question = Question.find(id)
            rescue ActiveRecord::RecordNotFound => _e
                GraphQL::ExecutionError.new('Question does not exist.')
            rescue ActiveRecord::RecordInvalid => e
                GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
            " #{e.record.errors.full_messages.join(', ')}")
        end
    end
end