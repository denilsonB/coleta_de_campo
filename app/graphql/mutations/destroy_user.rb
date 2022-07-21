module Mutations
    class DestroyUser < Mutations::BaseMutation
        argument :id, ID, required: true

        field :id, ID, null: true

        def resolve(id:)
            user = User.find(id)

            user.destroy
            {
                id:id
            }
        end
    end
end