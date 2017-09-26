class Escola < ApplicationRecord
  has_secure_password

  validates_presence_of :email, :CNPJ, :nome, :password
  validates_uniqueness_of :email
end
