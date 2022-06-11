class FormulariesController < ApplicationController
    before_action :authorize_request

    #GET /formularies
    def index
        @formularies = Formulary.all

        render json: @formularies, status: :ok
    end

    #GET /formularies/{id}
    def show
        @formulary = Formulary.find(params[:id])

        render json: @formulary, status: :ok
    end

    #POST /formularies
    def create
        @service = FormularyServices::Create.call(formulary_params)

        render_service
    end

    #PUT /formularies/{id}
    def update
        @service = FormularyServices::Update.call(params[:id],formulary_params)
        
        render_service
    end

    #DELETE /formularies/{id}
    def destroy
        @formulary = Formulary.find(params[:id])
        @formulary.destroy
        render json: {"message":"formulary deleted with success!"}
    end

    private
    
    def render_service
        if @service.success?
          render json: @service.result, status: :ok
        else
          render json: {  **@service.errors }, status: :unprocessable_entity
        end
    end

    def formulary_params
        params.permit(
            :name
        )
    end
end
