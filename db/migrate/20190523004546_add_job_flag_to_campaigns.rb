class AddJobFlagToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :job_flag, :boolean, :default => false
  end
end
