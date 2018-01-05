class CreateSpreeOpenpayPayments < ActiveRecord::Migration
  def change
    create_table :spree_openpay_payments do |t|
      t.string :type

      t.timestamps
    end
  end
end
