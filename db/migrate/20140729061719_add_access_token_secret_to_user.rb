class AddAccessTokenSecretToUser < ActiveRecord::Migration
  def change
    add_column :users, :access_token_secret, :string
  end
end
