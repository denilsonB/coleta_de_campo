module QuestionServices
    class Create < ApplicationService
        prepend SimpleCommand

        def initialize(quetion_params)
            @name = quetion_params[:name]
            @formulary_id = quetion_params[:formulary_id]
            @question_type = quetion_params[:question_type].to_i
            @image = quetion_params[:image]
        end

        def call
            create_quetion
        end

        private 
        def create_quetion
            question = Question.new(
                name: @name,
                formulary_id: @formulary_id,
                question_type: @question_type,
                image: @image
            )

            if !question.save 
                errors.add(:question, question.errors)
            else
                question
            end
        end
    end
end
