class UserPanelController < ApplicationController
  before_action :authenticate_user!
  def index
  end
  def profile
    @campaigns = current_user.campaigns.all.order("created_at DESC").each
    @donations = Array.new
    Donation.all.each do |d|
      if d.campaign.user_id == current_user.id
        @donations.push d
      end
    end
    # @funds = Campaign.find(params[:id]).donations
    # @funds_total = 0
    # @funds.each do |f|
    #   @funds_total = @funds_total + f.amount 
    # end
  end
  def view_invoice
    # @invoice = Stripe::Invoice.retrieve(params[:id])
    # @invoice = Stripe::Invoice.finalize_invoice(@invoice.id)
    # @invoice.send_invoice
    # @response = Stripe::Invoice.list(@invoice)
  end
end
