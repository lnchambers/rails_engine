class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.text :name
      t.text :description
      t.integer :unit_price

      t.timestamps
    end
  end
end
