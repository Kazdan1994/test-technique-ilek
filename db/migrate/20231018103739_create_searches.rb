class CreateSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :searches do |t|
      t.text :query, null: false, default: ''
      t.references :expert, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
