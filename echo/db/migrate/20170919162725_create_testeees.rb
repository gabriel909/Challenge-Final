class CreateTesteees < ActiveRecord::Migration[5.1]
  def change
    create_table :testeees do |t|

      t.timestamps
    end
  end
end
