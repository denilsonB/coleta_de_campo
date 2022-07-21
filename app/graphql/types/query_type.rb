module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    
    #user queries
    field :all_users, resolver: Queries::AllUsers
    field :one_user, resolver: Queries::OneUser

    #visit queries
    field :all_visits, resolver: Queries::AllVisits
    field :one_visit, resolver: Queries::OneVisit

    #formulary queries
    field :all_formularies, resolver: Queries::AllFormularies
    field :one_formulary, resolver: Queries::OneFormulary

    #question queries
    field :all_questions, resolver: Queries::AllQuestions
    field :one_question, resolver: Queries::OneQuestion

    #answer queries
    field :all_answers, resolver: Queries::AllAnswers
    field :one_answer, resolver: Queries::OneAnswer
  end
end
