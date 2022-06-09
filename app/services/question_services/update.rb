module QuestionServices
    class Update < ApplicationService
        prepend SimpleCommand

        def initialize(id, quetion_params)
            @id = id
            @params = quetion_params
        end

        def call
            update_quetion
        end

        private 
        def update_quetion
            question = Question.find(@id)
            @params[:question_type] = @params[:question_type].to_i

            if !question.update(@params) 
                errors.add(:question, question.errors)
            else
                question
            end
        end
    end
end
