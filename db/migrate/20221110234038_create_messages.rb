class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :ttl
      t.text :boost_chain
      t.integer :boost_type

      t.timestamps
    end

    change_column_default :messages, :ttl, 1
    change_column_default :messages, :b_chain, '---'
    change_column_default :messages, :b_type, 0
  end
end
