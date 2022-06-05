module UserServices
    class Create  < ApplicationService
        prepend SimpleCommand
        attr_reader :name, :password, :password_confirmation, :email, :cpf

        def initialize(user_params)
            @name = user_params[:name]
            @password = user_params[:password]
            @password_confirmation = user_params[:password_confirmation]
            @email = user_params[:email]
            @cpf = user_params[:cpf]
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
                errors.add(:user_error,user.errors)
            else
                user
            end
        end
    end
end