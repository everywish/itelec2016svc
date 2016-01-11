class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :necid
      t.string :city
      t.string :district
      t.string :party
      t.string :picture
      t.string :name
      t.string :gender
      t.string :age
      t.string :address
      t.string :occupation
      t.string :education
      t.string :career
      t.string :criminal_record

      t.timestamps null: false
    end
  end
end
