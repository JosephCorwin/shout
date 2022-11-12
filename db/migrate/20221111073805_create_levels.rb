class CreateLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :levels do |t|
      t.integer :level_no
      t.text :rewards
      t.integer :xp_needed

      t.timestamps
    end
  end
end
