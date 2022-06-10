class AnswersController < ApplicationController
    before_action :authorize_request
    before_action :current_question
    before_action :verify_information, only: [:update, :destroy]

    #GET /answers
    def index
        @answer = @question.answer
        render json: @answer, status: :ok
    end

    #POST /answers
    def create
        @service = AnswerServices::Create.call(answer_params)
        render_service
    end
    
    #PUT /answers/{id}
    def update
        @service = AnswerServices::Update.call(params[:id],answer_params)
        render_service
    end

    #DELETE /answer/{id}
    def destroy
        @answer = Answer.find(params[:id])
        @answer.destroy
        render json: {"message":"answer deleted with success!"}
    end

    private 
    def current_question
        @formulary = Formulary.find(params[:formulary_id])
        @question = @formulary.questions.find(params[:question_id])
    end

    def verify_information
        @answer = Answer.find(params[:id])
        unless @answer.formulary == @formulary && @answer.question==@question
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

    def answer_params
        params.permit(
            :content, :formulary_id, :question_id, :visit_id, :answered_at
        )
    end
end
