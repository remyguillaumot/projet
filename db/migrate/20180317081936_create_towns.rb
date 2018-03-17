class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :name
      t.string :postCode
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
