class CreateRequests < ActiveRecord::Migration[5.2]
  def up
    create_table :requests do |t|
      t.integer "amount"
      t.integer "campaign_id"
      t.integer "sender_id"
      t.integer "receiver_id"
      t.integer "response", default: 0

      t.timestamps
    end
  end

  def down
    drop_table :requests
  end
end
