class Answer < ApplicationRecord
  belongs_to :formulary
  belongs_to :question
  belongs_to :visit
  acts_as_paranoid

  validates :formulary, presence: true
  validates :question, presence: true
  
end
