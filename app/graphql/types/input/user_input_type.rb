module Types
    module Input
        class UserInputType < Types::BaseObject
            argument :name, String, required: true
            argument :password, String, required: true
            argument :password_confirmation, String, required: true
            argument :email, String, required: true
            argument :cpf, String, required: true
        end
    end
end