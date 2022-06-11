class VisitsController < ApplicationController
    before_action :authorize_request
    before_action :current_user
    before_action :verify_information, only: [:update, :destroy]

    #GET /visits
    def index
        @visits = @user.visits

        render json: @visits, status: :ok
    end

    #GET /visits/{id}
    def show
        @visit = @user.visits.find(params[:id])

        render json: @visit, status: :ok
    end

    #POST /visits
    def create
        @service = VisitServices::Create.call(visit_params)

        render_service
    end
    
    #PUT /visits/{id}
    def update
        @service = VisitServices::Update.call(params[:id],visit_params)

        render_service
    end

    #DELETE /visits/{id}
    def destroy
        @visit = Visit.find(params[:id])
        @visit.destroy

        render json: {"message":"visit deleted with success!"}
    end
    

    #POST /checkin/{id}
    def checkin
        @visit = Visit.find(params[:id])
        @visit.checkin

        render json: {"message":"checkin at #{@visit.checkin_at}"}
    end

    #POST /checkout/{id}
    def checkout
        @visit = Visit.find(params[:id])
        @visit.checkout
        
        render json: {"message":"checkout at #{@visit.checkout_at}"}
    end

    private

    def verify_information
        @visit = Visit.find(params[:id])
        unless VerificationServices::Verify.call(@visit.user,@current_user).result 
            render json: {"message":"Invalid request"}, status: :bad_request
        end
    end       
    
    def current_user
        @user = User.find(params[:user_id])
        unless VerificationServices::Verify.call(@user,@current_user).result
            render json: {"message":"User not allowed "}, status: :unauthorized
        end
    end

    def render_service
        if @service.success?
          render json: @service.result, status: :ok
        else
          render json: {  **@service.errors }, status: :unprocessable_entity
        end
    end

    def visit_params
        params.permit(
            :date, :status, :user_id, :checkin_at, :checkout_at
        )
    end

end
