module Mutations
    class AddUser < Mutations::BaseMutation
        argument :name, String, required: true
        argument :password, String, required: true
        argument :password_confirmation, String, required: true
        argument :email, String, required: true
        argument :cpf, String, required: true

        field :created_user, Types::UserType, null: true
        field :errors, [String], null: false
        
        def resolve(name:,password:,password_confirmation:,email:,cpf:)
            user_params = {
                name:name,
                password:password,
                password_confirmation:password_confirmation,
                email:email,
                cpf:cpf
            }
            service = UserServices::Create.call(user_params)

            if service.success?
                user = service.result

                {
                    created_user: user,
                    errors: []
                }
            else
                {
                    created_user: nil,
                    errors: service.errors.full_messages
                }
            end
        end
    end
end