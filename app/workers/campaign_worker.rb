class CampaignWorker
  include Sidekiq::Worker

  def perform(name, count, id)
    # Do something
    @campaign = Campaign.find(id)
    @campaign.active = false
    @campaign.save
    puts "Hello! #{@campaign.name} has been ended."
  end
end
