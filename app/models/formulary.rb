class Formulary < ApplicationRecord
    acts_as_paranoid
    
    NAME_REQUIREMENTS = /\A
    (?=.{3,}) #pelo menos 3 caracteres
    /x
    validates :name, uniqueness: true
    validates :name, format: NAME_REQUIREMENTS
end
