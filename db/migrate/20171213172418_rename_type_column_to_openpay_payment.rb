class RenameTypeColumnToOpenpayPayment < ActiveRecord::Migration
  def change
    rename_column :spree_openpay_payments, :type, :payment_type
    add_column :spree_openpay_payments, :first_name, :string
    add_column :spree_openpay_payments, :last_name, :string
  end
end
