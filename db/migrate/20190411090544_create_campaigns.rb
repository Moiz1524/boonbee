class CreateCampaigns < ActiveRecord::Migration[5.2]
  def up
    create_table :campaigns do |t|
      t.string "name"
      t.integer "occ_type"
      t.string "user_occ"
      t.date "occ_date"
      t.attachment "image"
      t.integer "user_id"
      t.boolean "active", default: true
      t.string "occ_details"

      t.timestamps
    end
  end

  def down
    drop_table :campaigns
  end
end
