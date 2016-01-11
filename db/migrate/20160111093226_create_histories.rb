class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :rawdata

      t.timestamps null: false
    end
  end
end
