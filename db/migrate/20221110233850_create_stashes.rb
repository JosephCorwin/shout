class CreateStashes < ActiveRecord::Migration[7.0]
  def change
    create_table :stashes do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :xp
      t.text :purse
      t.text :settings

      t.timestamps
    end

    change_column_default :stashes, :xp, 0
    change_column_default :stashes, :purse, '---'
  end
end
