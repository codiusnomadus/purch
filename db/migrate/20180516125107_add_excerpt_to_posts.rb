class AddExcerptToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column 'core.posts', :excerpt, :text
  end
end
