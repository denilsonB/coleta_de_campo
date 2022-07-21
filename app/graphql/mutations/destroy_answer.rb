module Mutations
    class DestroyAnswer < Mutations::BaseMutation
        argument :id, ID, required: true

        field :id, ID, null: true

        def resolve(id:)
            answer = Answer.find(id)

            answer.destroy
            {
                id:id
            }
        end
    end
end