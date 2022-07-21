module Queries
    class AllAnswers < Queries::BaseQuery
        type [Types::AnswerType], null: false
        
        def resolve
            Answer.all
        end
    end
end