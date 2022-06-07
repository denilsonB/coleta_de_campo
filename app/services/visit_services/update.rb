module VisitServices
    class Update < ApplicationService
        prepend SimpleCommand

        def initialize(id,visit_params)
            @id = id
            @params = visit_params
        end

        def call
            update_visit
        end

        private 
        def update_visit
            visit = Visit.find(@id)
            @params[:status] = @params[:status].to_i
            
            if (!visit.update(@params))  
                errors.add(:visit_erros, visit.errors)
            else
                visit
            end
        end
    end
end
