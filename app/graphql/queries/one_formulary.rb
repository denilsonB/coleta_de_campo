module Queries
    class OneFormulary < Queries::BaseQuery
        type Types::FormularyType, null: false

        argument :id, ID, required: true

        def resolve(id:)
            formulary = Formulary.find(id)
            rescue ActiveRecord::RecordNotFound => _e
                GraphQL::ExecutionError.new('Formulary does not exist.')
            rescue ActiveRecord::RecordInvalid => e
                GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
            " #{e.record.errors.full_messages.join(', ')}")
        end
    end
end