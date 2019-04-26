class AlterDonations < ActiveRecord::Migration[5.2]
  def up
    add_column("donations", "amount", :integer)
  end
  
  def down
    remove_column("donations", "amount")
  end
end
