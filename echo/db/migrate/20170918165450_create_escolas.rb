class CreateEscolas < ActiveRecord::Migration[5.1]
  def change
    create_table :escolas do |t|
      t.string :nome
      t.string :unidade
      t.string :CNPJ
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
