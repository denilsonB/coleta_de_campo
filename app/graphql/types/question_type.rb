# frozen_string_literal: true

module Types
  class QuestionType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :formulary_id, Integer, null: false
    field :formulary, Types::FormularyType, null: false
    field :question_type, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :deleted_at, GraphQL::Types::ISO8601DateTime
  end
end
