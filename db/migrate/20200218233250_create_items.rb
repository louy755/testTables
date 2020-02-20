class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :qunt
      t.string :item_type
      t.text :Description
      t.decimal :price
      t.decimal :org_price
      t.string :vendor
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
