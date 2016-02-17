class Addhistorytocan < ActiveRecord::Migration
  def change
    add_column :candidates, :history_id, :integer
    add_index :candidates, :history_id
  end
end
