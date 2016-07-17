class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :unique => true
      t.boolean :is_sent, default: false

      t.timestamps null: false
    end
  end
end
