class CreateBrands < ActiveRecord::Migration[5.0]
  def up
    create_table 'reference.brands', id: false do |t|
      t.string :name
      t.string :code
      t.boolean :active, default: true

      t.timestamps
    end
    execute "ALTER TABLE reference.brands ADD PRIMARY KEY (code);"

    Brand.create name: 'Apple', code: 'APPLE', active: true
    Brand.create name: 'Samsung', code: 'SAMSUNG', active: true
    Brand.create name: 'LG', code: 'LG', active: true
  end

  def down
    drop_table 'reference.brands'
  end

end
