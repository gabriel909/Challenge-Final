class CreateDenuncia < ActiveRecord::Migration[5.1]
  def change
    create_table :denuncia do |t|
      t.string :categoria
      t.string :descricao
      t.string :status
      t.string :imagem
      t.string :video
      t.references :aluno, foreign_key: true

      t.timestamps
    end
  end
end
