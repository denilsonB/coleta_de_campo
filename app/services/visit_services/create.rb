module VisitServices
    class Create < ApplicationService
        prepend SimpleCommand

        def initialize(visit_params)
            @date = visit_params[:date]
            @status = visit_params[:status].to_i
            @user_id = visit_params[:user_id]
            @checkin_at = visit_params[:checkin_at]
            @checkout_at = visit_params[:checkout_at]
        end

        def call
            create_visit
        end

        private 
        def create_visit
            visit = Visit.new(
                date: @date,
                status: @status,
                user_id: @user_id,
                checkin_at: @checkin_at,
                checkout_at: @checkout_at
            )

            if !visit.save 
                errors.add(:visit_erros, visit.errors)
            else
                visit
            end
        end
    end
end
