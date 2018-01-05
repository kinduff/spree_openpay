class AddUserIdToSpreeOpenpayPayment < ActiveRecord::Migration
  def change
    add_column :spree_openpay_payments, :user_id, :integer
    add_index :spree_openpay_payments, :user_id
  end
end
