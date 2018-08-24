class CreateIntercommunalities < ActiveRecord::Migration[5.0]
  def change
    create_table :intercommunalities do |t|
      t.string :name
      t.string :siren
      t.string :form

      t.timestamps
    end

    add_reference :intercommunalities, :siren, index: true, unique: true
  end
end
