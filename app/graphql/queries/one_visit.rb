module Queries
    class OneVisit < Queries::BaseQuery
        
        type Types::VisitType, null: false

        argument :id, ID, required: true

        def resolve(id:)
            Visit.find(id)
            rescue ActiveRecord::RecordNotFound => _e
                GraphQL::ExecutionError.new('Visit does not exist.')
            rescue ActiveRecord::RecordInvalid => e
                GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
            " #{e.record.errors.full_messages.join(', ')}")
        end

    end
end