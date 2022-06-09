module FormularyServices
    class Update < ApplicationService
        prepend SimpleCommand

        def initialize(id,formulary_params)
            @id = id
            @params = formulary_params
        end

        def call
            update_formulary
        end

        private 
        def update_formulary
            formulary = Formulary.find(@id)

            if !formulary.update(@params)
                errors.add(:formulary, formulary.errors)
            else
                formulary
            end
        end
    end
end
