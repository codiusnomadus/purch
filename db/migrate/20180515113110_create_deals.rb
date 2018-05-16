class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table 'core.deals' do |t|
      t.string :title
      t.string :brand_code
      t.string :price
      t.string :discount_code
      t.text :savings
      t.string :link

      t.integer :user_id

      t.timestamps
    end
  end
end
