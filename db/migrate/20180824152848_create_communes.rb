class CreateCommunes < ActiveRecord::Migration[5.0]
  def change
    create_table :communes do |t|
      t.references :intercommunality
      t.string :name
      t.string :code_insee

      t.timestamps
    end
  end
end
