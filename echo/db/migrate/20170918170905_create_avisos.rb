class CreateAvisos < ActiveRecord::Migration[5.1]
  def change
    create_table :avisos do |t|
      t.string :titulo
      t.string :descricao
      t.string :series

      t.timestamps
    end
  end
end
