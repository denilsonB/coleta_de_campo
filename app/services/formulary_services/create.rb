module FormularyServices
    class Create < ApplicationService
        prepend SimpleCommand

        def initialize(formulary_params)
            @name = formulary_params[:name]
        end

        def call
            create_formulary
        end

        private 
        def create_formulary
            formulary = Formulary.new(
                name: @name,
            )

            if !formulary.save 
                errors.add(:formulary, formulary.errors)
            else
                formulary
            end
        end
    end
end
