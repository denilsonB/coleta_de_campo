module Queries
    class AllUsers < Queries::BaseQuery
        type [Types::UserType], null: false

        def resolve
            User.all
        end
    end
end