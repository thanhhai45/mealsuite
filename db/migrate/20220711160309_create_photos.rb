class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :name, null: false, unique: true
      t.datetime :shooting_date
      t.text :description
      t.references :gallery, index: true, foreign_key: true
      t.timestamps
    end
  end
end
