class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string  :first_name
      t.string  :surname
      t.date    :birthday
      t.integer :height
      t.integer :weight

      t.timestamps
    end
  end
end
