class CreateEscolas < ActiveRecord::Migration[5.1]
  def change
    create_table :escolas do |t|
      t.string :unidade
      t.string :nome
      t.string :CNPJ
      t.string :email
      t.string :senha_digest

      t.timestamps
    end
  end
end
