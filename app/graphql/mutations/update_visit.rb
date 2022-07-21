module Mutations
    class UpdateVisit < Mutations::BaseMutation
        argument :id, ID, required: true
        argument :date, GraphQL::Types::ISO8601Date, required: false
        argument :status, Integer, required: false
        argument :user_id, ID, required: false
        argument :checkin_at, GraphQL::Types::ISO8601DateTime, required: false
        argument :checkout_at, GraphQL::Types::ISO8601DateTime, required: false

        field :updated_visit, Types::VisitType, null: true
        field :errors, [String], null: false

        def resolve(id:,**args)
            service = VisitServices::Update.call(id,args)

            if service.success?
                visit = service.result
                {
                    updated_visit: visit,
                    errors: []
                }
            else
                {
                    updated_visit: nil,
                    errors: service.errors.full_messages
                }
            end
        end
    end
end