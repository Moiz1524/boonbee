class DonationsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource :only => :index
    skip_before_action :verify_authenticity_token, :only => [:update]

    def index
        # @donations = Donation.all
        @campaigns = Campaign.where('occ_date > ?', Time.now.strftime("%a, %d %b %Y").to_date)
        # @d_total = 0
        # @donations.each do |d|
        #     @d_total = @d_total + d.amount
        # end
    end

    def new
        @donation = Donation.new
    end

    def create
        @donation = current_user.donations.new(donation_params)
        @donation_receiver = @donation.campaign.user.username
        @amount = @donation.amount * 100
        customer = Stripe::Customer.create({
            email: current_user.email,
            source: params[:stripeToken],
        })

        charge = Stripe::Charge.create({
            customer: customer.id,
            amount: @amount,
            description: 'Boonbee Stripe customer',
            currency: 'usd'
            # source: 'tok_visa',
            # transfer_data: {
            #     destination: '<%= current_user.stripe_user_id %>'
            # }
         })

        # invoiceItem = Stripe::InvoiceItem.create({
        #     customer: customer.id,
        #     amount: @amount,
        #     currency: 'usd',
        #     description: 'Campaign contribution',
        # })

        # invoice = Stripe::Invoice.create({
        #   customer: customer.id,
        # })

        # Stripe::Invoice.finalize_invoice(invoice.id)

        @donation.stripe_id = charge.id
        @donation.save!

        rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_donation_path
    end

    def preview_receiver
      @gift_giver = Donation.where(:user_id => params[:gift_giver]).last
      @campaign_name = @gift_giver.campaign.name
      @donation_amount = @gift_giver.amount
    end

    def donation_params
        params.require(:donation).permit(:amount, :user_id, :campaign_id, :stripeId)
    end
end
