module Mutations
    class DestroyQuestion < Mutations::BaseMutation
        argument :id, ID, required: true
        
        field :id, ID, null: true

        def resolve(id:)
            question = Question.find(id)

            question.destroy
            {
                id:id
            }
        end
    end
end