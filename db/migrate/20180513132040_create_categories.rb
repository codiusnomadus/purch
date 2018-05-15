class CreateCategories < ActiveRecord::Migration[5.0]
  def up
    # Create schema
    execute "CREATE SCHEMA reference;"

    # Create table
    create_table 'reference.categories' do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end

  def down
    # Drop table
    drop_table 'reference.categories'

    # Drop schema
    execute "DROP SCHEMA reference;"
  end
end
