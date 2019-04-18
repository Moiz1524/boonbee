class AlterCampaigns < ActiveRecord::Migration[5.2]
  
  def up
    remove_column("campaigns", "occ_funds")
  end
  
  def down
    add_column("campaigns", "occ_funds", :string)
  end

end
