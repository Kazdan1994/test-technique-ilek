class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer     :rating
      t.text        :message
      t.references  :wine, null: false, foreign_key: true
      t.references  :expert, null: false, foreign_key: true

      t.timestamps
    end
  end
end
