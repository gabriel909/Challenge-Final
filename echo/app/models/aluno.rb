class Aluno < ApplicationRecord
  belongs_to :escola

  has_secure_password
end
