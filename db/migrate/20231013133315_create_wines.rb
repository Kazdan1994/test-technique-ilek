class CreateWines < ActiveRecord::Migration[7.1]
  def change
    create_table :wines do |t|
      t.string  :name
      t.text    :properties
      t.float   :price
      t.string  :marketplace
      t.float   :note
      t.string  :wine_type

      t.timestamps
    end
  end
end
