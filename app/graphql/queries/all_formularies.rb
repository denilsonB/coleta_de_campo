module Queries
    class AllFormularies < Queries::BaseQuery

         type [Types::FormularyType], null: false

         def resolve
            Formulary.all
         end
    end
end