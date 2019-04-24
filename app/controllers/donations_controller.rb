class DonationsController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @donation = Donation.new
    end
    
    def create
        @donation = current_user.donations.new(donation_params)
        @donation.amount = @donation.amount * 100
        @amount = @donation.amount
    
        customer = Stripe::Customer.create({
            email: current_user.email,
            source: params[:stripeToken],
        })
    
        charge = Stripe::Charge.create({
            customer: customer.id,
            amount: @amount,
            description: 'Boonbee Stripe customer',
            currency: 'usd',
         })
        
        @donation.save!
             
        rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_donation_path
           
    end
    
    def payment
        
    end
    
    def donation_params
        params.require(:donation).permit(:amount, :user_id, :campaign_id)
    end
end
