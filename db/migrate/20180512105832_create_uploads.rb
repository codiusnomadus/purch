class CreateUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :uploads do |t|
      t.text :upload_data
      t.boolean :featured
      t.integer :uploadable_id
      t.string :uploadable_type

      t.timestamps
    end
    add_index :uploads, [:uploadable_id, :uploadable_type]
  end
end
