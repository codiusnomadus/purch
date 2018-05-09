class AddUserIdTo < ActiveRecord::Migration[5.0]
  def change
    add_column 'core.products', :user_id, :integer
  end
end
