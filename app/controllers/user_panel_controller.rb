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
    require 'net/http'
    require 'uri'
    require 'json'

    uri = URI.parse("https://connect.stripe.com/oauth/token")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      "client_secret" => ENV["stripe_api_key"],
      "code" => params[:code],
      "grant_type" => "authorization_code",
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    # response.code
    puts response.body
    hash = JSON.parse(response.body)
    if current_user.update(:stripe_user_id => hash["stripe_user_id"])
      flash[:notice] = "User connected with Boonbee platform!."
      redirect_to(myprofile_path)
    end
  end

  def revoke_stripe_connect

    if current_user.stripe_user_id != nil
      acct = Stripe::Account.retrieve(current_user.stripe_user_id)
      acct.deauthorize(ENV['stripe_client_key'])
      current_user.update(:stripe_user_id => nil)
      flash[:notice] = "You are disconnected from boonbee platform!."
      redirect_to(myprofile_path)
    else

    end
  end

  def new_user_occasion
    respond_to do |format|
      # format.html { redirect_to(root_path) }
      @types = Campaign.occ_type_options
      format.js {}
    end
  end
end
