class RemoveColumnsFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column 'core.products', :image_data
  end
end
