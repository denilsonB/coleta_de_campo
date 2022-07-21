module Mutations
    class UpdateUser < Mutations::BaseMutation
        argument :id, Integer, required: true
        argument :name, String, required: false
        argument :password, String, required: false
        argument :email, String, required: false
        argument :cpf, String, required: false

        field :updated_user, Types::UserType, null: true
        field :errors, [String], null: false

        def resolve(id:,**args)

            service = UserServices::Update.call(id,args)

            if service.success?
                user = service.result
                
                {
                    updated_user: user,
                    errors: []
                }
            else 
                {
                    updated_user: nil,
                    errors: service.errors.full_messages
                }
            end
        end
    end
end