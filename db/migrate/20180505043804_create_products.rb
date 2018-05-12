class CreateProducts < ActiveRecord::Migration[5.0]
  def up
    # Create schema
    execute "CREATE SCHEMA core;"

    # Create table
    create_table 'core.products' do |t|
      t.string :name, null: false
      t.string :price
      t.string :description

      t.timestamps
    end
  end

  def down
    # Drop table
    drop_table 'core.products'

    # Drop schema
    execute "DROP SCHEMA core;"
  end
end
