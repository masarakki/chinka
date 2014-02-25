class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick
      t.string :uid
      t.string :access_token
      t.string :secret_token
      t.index :uid, unique: true
      t.timestamps
    end
  end
end
