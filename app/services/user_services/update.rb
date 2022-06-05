module UserServices
    class Update  < ApplicationService
        prepend SimpleCommand

        def initialize(id,params)
            @id = id
            @params = params
        end

        def call 
            update_user
        end
        
        private 

        def update_user
            user = User.find(@id)

            if !user.update(@params)
                errors.add(:user_error,user.errors)
            else
                user
            end
        end
        
    end
end