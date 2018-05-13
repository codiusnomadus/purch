class AddExcerptToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column 'core.reviews', :excerpt, :text
  end
end
