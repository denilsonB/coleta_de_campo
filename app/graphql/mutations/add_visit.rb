module Mutations
    class AddVisit < Mutations::BaseMutation
        argument :date, GraphQL::Types::ISO8601Date, required: true
        argument :status, Integer, required: false
        argument :user_id, ID, required: true
        argument :checkin_at, GraphQL::Types::ISO8601DateTime, required: true
        argument :checkout_at, GraphQL::Types::ISO8601DateTime, required: true

        field :created_visit, Types::VisitType, null: true
        field :errors, [String], null: false

        def resolve(**args)
            service = VisitServices::Create.call(args)

            if service.success?
                visit = service.result
                {
                    created_visit: visit,
                    errors: []
                }
            else
                {
                    created_visit: nil,
                    errors: service.errors.full_messages
                }
            end
        end
    end
end