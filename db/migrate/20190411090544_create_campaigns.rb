class CreateCampaigns < ActiveRecord::Migration[5.2]
  def up
    create_table :campaigns do |t|
      t.string "name"
      t.integer "occ_type"
      t.date "occ_date"
      t.attachment "image"
      t.integer "user_id"
      t.string "occ_details"
      t.string "occ_funds"
      
      t.timestamps 
    end
  end
  
  def down
    drop_table :campaigns
  end
end
