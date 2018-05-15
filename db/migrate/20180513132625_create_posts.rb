class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table 'core.posts' do |t|
      t.string :title
      t.text :body
      t.references :category, index: true
      t.integer :user_id

      t.timestamps
    end
  end
end
