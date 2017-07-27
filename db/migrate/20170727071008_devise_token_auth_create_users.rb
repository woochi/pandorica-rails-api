class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.1]
  def change
    ## Required
    add_column :users, :provider, :string, :null => false, :default => "email"
    add_column :users, :uid, :string, :null => false, :default => ""

    ## Tokens
    add_column :users, :tokens, :json

    add_index :users, [:uid, :provider],     unique: true
  end
end
