class RemoveIndexFromTitle < ActiveRecord::Migration
  def change
    remove_index :posts, :title
  end
end
