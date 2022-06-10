module AnswerServices
    class Update < ApplicationService
        prepend SimpleCommand

        def initialize(id,answer_params)
            @id = id
            @params = answer_params
        end

        def call
            update_answer
        end

        private 
        def update_answer
            answer = Answer.find(@id)

            if !answer.update(@params)
                errors.add(:answer, answer.errors)
            else
                answer
            end
        end
    end
end
