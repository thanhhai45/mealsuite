class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.string :name, null: false, unique: true
      t.text :description, null: false

      t.timestamps
    end
  end
end
