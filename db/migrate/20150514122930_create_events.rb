class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string     :action
      t.integer    :half
      t.integer    :second
      t.float      :pos_x
      t.float      :pos_y
      t.references :player, index: true

      t.timestamps
    end
  end
end
