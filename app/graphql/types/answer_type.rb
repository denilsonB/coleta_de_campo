# frozen_string_literal: true

module Types
  class AnswerType < Types::BaseObject
    field :id, ID, null: false
    field :content, String
    field :formulary_id, Integer, null: false
    field :formulary, Types::FormularyType, null: false
    field :question_id, Integer, null: false
    field :question, Types::QuestionType, null: false
    field :visit_id, Integer, null: false
    field :visit, Types::VisitType, null: false
    field :answered_at, GraphQL::Types::ISO8601DateTime
    field :deleted_at, GraphQL::Types::ISO8601DateTime
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
