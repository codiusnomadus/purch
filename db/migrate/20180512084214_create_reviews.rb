class CreateReviews < ActiveRecord::Migration[5.0]
  def up
    create_table 'core.reviews' do |t|
      t.string :title
      t.text :body
      t.text :verdict
      t.references :user

      t.timestamps
    end
  end

  def down
    drop_table 'core.reviews'
  end
end
