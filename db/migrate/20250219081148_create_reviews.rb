class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.string :content
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
