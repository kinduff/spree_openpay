class AddPaymentMethodIdToSpreeOpenpayPayment < ActiveRecord::Migration
  def change
    add_column :spree_openpay_payments, :payment_method_id, :integer
    add_index :spree_openpay_payments, :payment_method_id
  end
end
