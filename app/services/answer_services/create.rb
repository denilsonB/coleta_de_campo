module AnswerServices
    class Create < ApplicationService
        prepend SimpleCommand

        def initialize(answer_params)
            @content = answer_params[:content]
            @formulary_id = answer_params[:formulary_id]
            @question_id = answer_params[:question_id]
            @visit_id = answer_params[:visit_id]
            @answered_at = answer_params[:answered_at]
        end

        def call
            create_answer
        end

        private 
        def create_answer
            answer = Answer.new(
                content: @content,
                formulary_id: @formulary_id,
                question_id: @question_id,
                visit_id: @visit_id,
                answered_at: @answered_at
            )

            if !answer.save 
                errors.add(:answer, answer.errors)
            else
                answer
            end
        end
    end
end
