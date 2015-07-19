class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick, null: false
      t.string :uid, null: false
      t.string :access_token, null: false
      t.string :secret_token, null: false
      t.timestamps null: false
      t.index :uid, unique: true
    end
  end
end
