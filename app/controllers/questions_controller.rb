class QuestionsController < ApplicationController
    before_action :authorize_request
    before_action :current_form
    before_action :verify_information, only: [:update, :destroy]

    #GET /questions
    def index
        @questions = @formulary.questions
        render json: @questions, status: :ok
    end

    #GET /questions/{id}
    def show
        @question = @formulary.questions.find(params[:id])
        render json: @question, status: :ok
    end

    #POST /questions
    def create
        @service = QuestionServices::Create.call(quetion_params)
        render_service
    end

    #PUT /questions/{id}
    def update
        @service = QuestionServices::Update.call(params[:id],quetion_params)
        render_service
    end

    #DELETE /questions/{id}
    def destroy
        @question = Question.find(params[:id])
        @question.destroy
        render json: {"message":"question deleted with success!"}
    end

    private

    def current_form
        @formulary = Formulary.find(params[:formulary_id])
    end

    def verify_information
        @question = Question.find(params[:id])
        unless @question.formulary == @formulary
            render json: {"message":"Invalid url"}, status: :bad_request
        end
    end

    def render_service
        if @service.success?
          render json: @service.result, status: :ok
        else
          render json: {  **@service.errors }, status: :unprocessable_entity
        end
    end

    def quetion_params
        params.permit(
            :name, :formulary_id, :question_type, :image
        )
    end
end
