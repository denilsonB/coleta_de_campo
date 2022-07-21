module Mutations
    class AddFormulary < Mutations::BaseMutation
        argument :name, String, required: true

        field :created_form, Types::FormularyType,null: true
        field :errors, [String], null: false

        def resolve(**params)
            service = FormularyServices::Create.call(params)

            if service.success?
                formulary = service.result
                {
                    created_form: formulary,
                    errors: []
                }
            else
                {
                    created_form: nil,
                    errors: service.errors.full_messages
                }
            end
        end
    end
end