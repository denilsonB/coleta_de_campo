module UserServices
    class CreateUserService  < ApplicationService
        prepend SimpleCommand
        attr_reader :name, :password, :password_confirmation, :email, :cpf

        def initialize(name,password,password_confirmation,email,cpf)
            @name = name
            @password = password
            @password_confirmation = password_confirmation
            @email = email
            @cpf = cpf
        end

        def call 
            create_user
        end
        
        private 

        def create_user
            user = User.new(
                name: @name,
                password: @password,
                password_confirmation: @password_confirmation,
                email: @email,
                cpf: @cpf
            )

            if !user.save
                user.errors
            else
                user
            end
        end
    end
end