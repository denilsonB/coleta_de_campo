module Queries
    class AllVisits < Queries::BaseQuery

        type [Types::VisitType], null: false

        def resolve
            Visit.all
        end
    end
end