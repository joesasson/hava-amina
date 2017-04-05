class RemoveEmailAndPasswordFromIdentities < ActiveRecord::Migration[5.1]
  def change
    remove_column :identities, :email, :string
    remove_column :identities, :encrypted_password, :string
  end
end
