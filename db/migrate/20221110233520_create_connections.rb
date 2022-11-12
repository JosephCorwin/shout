class CreateConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :connections do |t|
      t.references :castable, polymorphic: true, null: false
      t.references :receivable, polymorphic: true, null: false
      t.datetime :approved_at

      t.timestamps
    end
  end
end
