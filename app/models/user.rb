class User < ApplicationRecord
    has_secure_password
    acts_as_paranoid
    
    PASSWORD_REQUIREMENTS = /\A 
    (?=.{6,}) #pelo menos 6 caracteres
    (?=.*\d)  #pelo menos 1 numero
    (?=.*[a-z]) #contem uma letra minuscula
    (?=.*[A-Z])  #contem uma letra maiuscula
    /x
    validates :password, format: PASSWORD_REQUIREMENTS
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :cpf , presence: true, uniqueness: true
    validates_cpf_format_of :cpf

end
