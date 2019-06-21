class AddStripeConnectIdToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column("users", "stripe_user_id", :string)
  end

  def down
    remove_column("users", "stripe_user_id")
  end
end
