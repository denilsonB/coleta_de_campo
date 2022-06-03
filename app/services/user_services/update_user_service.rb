module UserServices
    class UpdateUserService  < ApplicationService
        prepend SimpleCommand

        def initialize(id,params)
            @id = id
            @params = params
            @errors = []
        end

        def call 
            update_user
        end
        
        private 

        def update_user
            user = User.find(@id)

            if !user.update(@params)
                user.errors
            else
                user
            end
        end
        
    end
end