module Queries
    class AllQuestions < Queries::BaseQuery
        
        type [Types::QuestionType], null: false

        def resolve
            Question.all
        end
    end
end