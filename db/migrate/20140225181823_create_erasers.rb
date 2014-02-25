class CreateErasers < ActiveRecord::Migration
  def change
    create_table :erasers do |t|
      t.integer :user_id, null: false
      t.string :twitter_name, null: false
      t.string :twitter_id, null: false
      t.index [:user_id, :twitter_id], unique: true
      t.index :twitter_id
      t.timestamps
    end
  end
end
