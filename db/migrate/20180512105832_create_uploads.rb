class CreateUploads < ActiveRecord::Migration[5.0]
  def up
    create_table 'core.uploads' do |t|
      t.text :upload_data
      t.boolean :featured
      t.integer :uploadable_id
      t.string :uploadable_type

      t.timestamps
    end
    add_index :uploads, [:uploadable_id, :uploadable_type]
  end

  def down
    remove_index(:uploads, name: "index_uploads_on_uploadable_id_and_uploadable_type")
    drop_table 'core.uploads'
  end
end
