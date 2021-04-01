class DropPasswordDigest < ActiveRecord::Migration[6.1]
  def change
    drop_table :add_password_digest
  end
end


