class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.integer "amount"
      t.integer "user_id"
      t.integer "campaign_id"

      t.timestamps
    end
  end
end
