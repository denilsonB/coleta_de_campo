class Visit < ApplicationRecord
  belongs_to :user
  acts_as_paranoid

  enum status: {PENDENTE: 0, REALIZANDO: 1, REALIZADA: 2}

end
