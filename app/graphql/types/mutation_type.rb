module Types
  class MutationType < Types::BaseObject
    #Users mutations
    field :add_user, mutation: Mutations::AddUser
    field :update_user, mutation: Mutations::UpdateUser
    field :destroy_user, mutation: Mutations::DestroyUser

    #Visits mutations
    field :add_visit, mutation: Mutations::AddVisit
    field :update_visit, mutation: Mutations::UpdateVisit
    field :destroy_visit, mutation: Mutations::DestroyVisit

    #Formularies mutations
    field :add_formulary, mutation: Mutations::AddFormulary
    field :update_formulary, mutation: Mutations::UpdateFormulary
    field :destroy_formulary, mutation: Mutations::DestroyFormulary

    #question mutations
    field :add_question, mutation: Mutations::AddQuestion
    field :update_question, mutation: Mutations::UpdateQuestion
    field :destroy_question, mutation: Mutations::DestroyQuestion

    #answer mutations
    field :add_answer, mutation: Mutations::AddAnswer
    field :update_answer, mutation: Mutations::UpdateAnswer
    field :destroy_answer, mutation: Mutations::DestroyAnswer
  end
end
