class AddBrandCodeToProductsAndReviews < ActiveRecord::Migration[5.0]
  def change
    add_column 'core.products', :brand_code, :string, index: true
    add_column 'core.reviews', :brand_code, :string, index: true
  end
end
