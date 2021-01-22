class RenameCommentColumnToComments < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :comment, :text
  end
end
