module Mutations
    class DestroyVisit < Mutations::BaseMutation
        argument :id, ID, required: true

        field :id, ID, null: true

        def resolve(id:)
            visit = Visit.find(id)

            visit.destroy
            {
                id:id
            }
        end
    end
end