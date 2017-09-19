class CreatePlanos < ActiveRecord::Migration[5.1]
  def change
    create_table :planos do |t|
      t.string :nome
      t.float :preco
      t.integer :qtdAlunos

      t.timestamps
    end
  end
end
