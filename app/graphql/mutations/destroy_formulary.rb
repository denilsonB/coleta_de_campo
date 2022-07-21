module Mutations
    class DestroyFormulary < Mutations::BaseMutation
        argument :id, ID, required: true 

        field :id, ID, null: true

        def resolve(id:)
            formulary = Formulary.find(id)

            formulary.destroy
            {
                id:id
            }
        end
    end
end