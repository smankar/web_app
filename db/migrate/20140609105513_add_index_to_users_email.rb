class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :uploads, :email, unique: true
  end
end
