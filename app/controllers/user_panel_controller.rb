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

  def stripe_connect_handler
  #   require 'net/http'
  #   require 'uri'
  #   require 'json'
  #
  #   uri = URI.parse("https://connect.stripe.com/oauth/token")
  #   request = Net::HTTP::Post.new(uri)
  #   request.set_form_data(
  #     "client_secret" => ENV["stripe_api_key"],
  #     "code" => params[:code],
  #     "grant_type" => "authorization_code",
  #   )
  #
  #   req_options = {
  #     use_ssl: uri.scheme == "https",
  #   }
  #
  #   response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  #     http.request(request)
  #   end
  #
  #   # response.code
  #   puts response.body
  #   if current_user.update(:stripe_user_id => response.body.stripe_user_id)
  #     flash[:notice] => "User connected with Boonbee platform!."
  #   end
  # end
  end
end
