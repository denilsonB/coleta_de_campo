class Question < ApplicationRecord
  acts_as_paranoid
  belongs_to :formulary
  has_one_attached :image
  
  enum question_type: {TEXTO: 0, FOTO: 1, }
  validates :image, presence: true, if: -> {question_type == "FOTO"}
  validates_uniqueness_of :name, scope: :formulary_id


end
