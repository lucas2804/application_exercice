class CreateDataImports < ActiveRecord::Migration[5.0]
  def change
    create_table :data_imports do |t|
      t.string :filename
      t.datetime :failed_at
      t.datetime :imported_at
      t.datetime :processed_at
      t.text :error_message

      t.timestamps
    end
  end
end
