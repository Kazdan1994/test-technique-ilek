class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.integer     :price, null: false
      t.date        :date, null: false
      t.references  :wine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
