class AddDeviceSessionIdToSpreeOrder < ActiveRecord::Migration
  def change
    add_column :spree_orders, :device_session_id, :string
  end
end
