class AddOpenpayIdToSpreeUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :openpay_id, :string
  end
end
