class CreateDonations < ActiveRecord::Migration[5.2]
  def up
    create_table :donations do |t|
      t.integer "campaign_id"
      t.integer "user_id"
      t.string "stripe_id"
      
      t.timestamps
    end
  end
  
  def down
    drop_table :donations
  end
end
