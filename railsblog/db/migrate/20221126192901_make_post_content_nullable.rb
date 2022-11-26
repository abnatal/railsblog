class MakePostContentNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :posts, :content, true
  end
end
