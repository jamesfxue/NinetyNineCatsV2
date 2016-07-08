class ChangeCats2 < ActiveRecord::Migration
  def change
    change_column_default :cats, :user_id, nil
  end
end
