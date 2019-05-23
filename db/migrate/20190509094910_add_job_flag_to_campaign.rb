class AddJobFlagToCampaign < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :job_flag, :boolean, :default => false
    remove_column :campaigns, :jobFlag
  end
end
