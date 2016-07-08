class ChangeCats < ActiveRecord::Migration
  def change
    change_table :cats do |t|
      t.integer :user_id, null: false, default: 1
    end
    add_index :cats, :user_id
  end
end
