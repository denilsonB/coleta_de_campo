# frozen_string_literal: true

module Types
  class VisitType < Types::BaseObject
    field :id, ID, null: false
    field :date, GraphQL::Types::ISO8601Date
    field :status, Integer
    field :user_id, Integer, null: false
    field :user, Types::UserType, null: false
    field :checkin_at, GraphQL::Types::ISO8601DateTime
    field :checkout_at, GraphQL::Types::ISO8601DateTime
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :deleted_at, GraphQL::Types::ISO8601DateTime
  end
end
