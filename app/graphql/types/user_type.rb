# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :password_digest, String
    field :email, String
    field :cpf, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :deleted_at, GraphQL::Types::ISO8601DateTime
  end
end
