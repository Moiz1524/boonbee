class CashOutWorker
  include Sidekiq::Worker

  def perform(name, count, id)
    # Do something
    @campaign = Campaign.find(id)
    @campaign.job_flag = true
    @campaign.save
    puts "Hello!."
  end
end
