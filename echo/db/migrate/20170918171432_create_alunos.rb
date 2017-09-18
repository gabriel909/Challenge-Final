class CreateAlunos < ActiveRecord::Migration[5.1]
  def change
    create_table :alunos do |t|
      t.string :nome
      t.string :email
      t.string :password_digest
      t.string :serie
      t.references :escola, foreign_key: true

      t.timestamps
    end
  end
end
