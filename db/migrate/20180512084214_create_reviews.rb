class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.text :verdict
      t.references :user

      t.timestamps
    end
  end
end
