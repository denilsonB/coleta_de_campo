module Mutations
    class UpdateFormulary < Mutations::BaseMutation
        argument :id, ID, required: true
        argument :name, String, required: true

        field :updated_form, Types::FormularyType, null: true
        field :errors, [String], null: false

        def resolve(id:,**params)
            service = FormularyServices::Update.call(id,params)

            if service.success?
                form = service.result
                {
                    updated_form: form,
                    errors: []
                }
            else
                {
                    updated_form: nil,
                    errors: service.errors.full_messages
                }
            end
        end
    end
end