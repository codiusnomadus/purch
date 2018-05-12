class AddImageDateToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column 'core.products', :image_data, :text
  end
end
