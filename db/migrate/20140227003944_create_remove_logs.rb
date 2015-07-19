class CreateRemoveLogs < ActiveRecord::Migration
  def change
    create_table :remove_logs do |t|
      t.integer :user_id, null: false
      t.integer :eraser_id, null: false
      t.text :body
      t.timestamps null: false
      t.index [:user_id, :eraser_id]
    end
  end
end
